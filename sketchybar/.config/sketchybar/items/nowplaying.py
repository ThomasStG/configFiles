import json
import os
import socket
import subprocess
from pathlib import Path

SKETCHYBAR_ITEM = "nowplaying"


def format_duration(seconds):
    minutes = seconds // 60
    seconds = seconds % 60
    return f"{minutes}:{seconds:02}"


def get_ncspot_song():
    sock_path = Path("/tmp") / f"ncspot-{os.getuid()}" / "ncspot.sock"
    if not sock_path.exists():
        return None

    try:
        with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as client:
            client.settimeout(1)
            client.connect(str(sock_path))
            data = client.recv(8192).decode("utf-8")
            message = json.loads(data)

            mode = message.get("mode")

            if "Playing" in mode:
                playable = message.get("playable", {})
                title = playable.get("title", "Unknown Title")
                artists = playable.get("artists", ["Unknown Artist"])
                album = playable.get("album", "Unknown Album")
                cover_url = playable.get("cover_url")

                return f" - {artists[0]} – {title}"
            return ""
    except (socket.timeout, json.JSONDecodeError, OSError):
        return None


def is_rmpc_playing():
    r = subprocess.run(["rmpc", "status"], capture_output=True, text=True)
    lines = r.stdout.strip().splitlines()

    json_line = next((line for line in lines if line.startswith("{")), None)
    if not json_line:
        return False

    try:
        data = json.loads(json_line)
        return data.get("state", "").lower() == "play"
    except json.JSONDecodeError:
        return False


def get_rmpc_song():
    r = subprocess.run(["rmpc", "song"], capture_output=True, text=True)
    lines = r.stdout.strip().splitlines()
    json_line = next((line for line in lines if line.startswith("{")), None)
    if not json_line:
        return ""

    try:
        data = json.loads(json_line).get("metadata", {})
        artist = data.get("artist", "").strip()
        title = data.get("title", "").strip()
        if artist or title:
            return f" {artist} – {title}"
        else:
            return ""
    except json.JSONDecodeError:
        return ""


def get_nowplaying_info():
    result = subprocess.run(
        ["nowplaying-cli", "get-raw"],
        capture_output=True,
        text=True,
    ).stdout.strip()

    if not result:
        return ""

    info = {}
    for line in result.splitlines():
        if "=" in line:
            key, value = line.split("=", 1)
            info[key.strip()] = value.strip().strip(";").strip('"')

    title = info.get("kMRMediaRemoteNowPlayingInfoTitle", "Unknown Title")
    artist = info.get("kMRMediaRemoteNowPlayingInfoArtist", "Unknown Artist")
    album = info.get("kMRMediaRemoteNowPlayingInfoAlbum", "Unknown Album")

    isplaying = subprocess.run(
        ["nowplaying-cli", "get", "playbackRate"],
        capture_output=True,
        text=True,
    ).stdout.strip()

    if isplaying == "1":
        return f" - {artist} – {title}"
    return ""


def is_ncspot_running():
    try:
        subprocess.check_output(["pgrep", "-x", "ncspot"])
        return True
    except subprocess.CalledProcessError:
        return False


def update_sketchybar(label: str):
    cmd = ["sketchybar", "--set", SKETCHYBAR_ITEM, f"label={label}", "icon= "]

    cmd += ["icon.drawing=off"]

    subprocess.run(cmd)


def main():
    label = get_nowplaying_info()
    if not label and is_ncspot_running():
        label = get_ncspot_song()
    # if not label and is_rmpc_playing():
    #     label = get_rmpc_song()
    # if not label:
    if label == "":
        label = "No track playing."

    update_sketchybar(label)


if __name__ == "__main__":
    main()
