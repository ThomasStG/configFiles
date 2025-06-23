#!/usr/bin/env python3

import re
import time
from pathlib import Path

log_path = Path.home() / ".config" / "ncspot" / "debug.log"
output_path = Path.home() / ".cache" / "nowplaying.txt"

track_pattern = re.compile(
    r'title: "(.*?)".*?artists: \[(.*?)\].*?album: Some\("(.*?)"\)', re.DOTALL
)


def follow(file):
    """Generator to yield new lines in a file like `tail -f`."""
    file.seek(0, 2)
    while True:
        line = file.readline()
        if not line:
            time.sleep(0.2)
            continue
        yield line


def parse_line(line):
    match = track_pattern.search(line)
    if match:
        title = match.group(1)
        artist = match.group(2).strip('"')
        album = match.group(3)
        return f"{artist} – {title}\nAlbum: {album}"
    return None


def main():
    with open(log_path, "r", encoding="utf-8") as logfile:
        for line in follow(logfile):
            if "Load(Track" in line:
                info = parse_line(line)
                if info:
                    output_path.parent.mkdir(parents=True, exist_ok=True)
                    with open(output_path, "w", encoding="utf-8") as out:
                        out.write(info)


if __name__ == "__main__":
    main()
