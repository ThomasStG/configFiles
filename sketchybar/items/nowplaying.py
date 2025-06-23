import json
import os
import socket
import subprocess
from pathlib import Path

IMG_PATH = "/tmp/nowplaying.jpg"
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

                # Download album cover (if available)
                if cover_url:
                    try:
                        subprocess.run(
                            ["curl", "-s", "-o", IMG_PATH, cover_url], check=True
                        )
                    except subprocess.CalledProcessError:
                        pass  # Image download failed, silently continue

                return f" - {artists[0]} – {title}"
            return ""
    except (socket.timeout, json.JSONDecodeError, OSError):
        return None


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

    # Save artwork if available
    try:
        art = subprocess.run(
            [
                "nowplaying-cli",
                "get",
                "kMRMediaRemoteNowPlayingInfoArtworkData",
                "--data",
            ],
            stdout=subprocess.PIPE,
            stderr=subprocess.DEVNULL,
        )
        if art.returncode == 0 and art.stdout:
            with open(IMG_PATH, "wb") as f:
                f.write(art.stdout)
    except Exception:
        pass  # Ignore image errors

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

    if Path(IMG_PATH).is_file():
        cmd += [
            f"background.image={IMG_PATH}",
            "icon.drawing=on",
            "icon.padding_right=6",
            "icon.background.image.scale=0.8",
            "icon.background.image.corner_radius=4",
            "icon.background.height=24",
            "icon.background.y_offset=0",
        ]
    else:
        cmd += ["icon.drawing=off"]

    subprocess.run(cmd)


def main():
    label = get_nowplaying_info()
    if not label and is_ncspot_running():
        label = get_ncspot_song()

    if not label:
        label = "No track playing."

    update_sketchybar(label)


if __name__ == "__main__":
    main()
