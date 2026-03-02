import json
import subprocess


def get_rmpc_song():
    rmpc = subprocess.run(["rmpc", "song"], capture_output=True, text=True)
    if rmpc.returncode != 0:
        return ""

    try:
        data = json.loads(rmpc.stdout).get("metadata", {})
        return f" {data.get('artist', '')} – {data.get('title', '')}"
    except json.JSONDecodeError:
        return ""


print(get_rmpc_song())
