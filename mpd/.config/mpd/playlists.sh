#!/bin/bash

MUSIC_DIR="$HOME/.music"  # Or wherever your music_directory is
PLAYLIST_DIR="$HOME/.music/mpd/playlists"

mkdir -p "$PLAYLIST_DIR"

find "$MUSIC_DIR" -mindepth 1 -maxdepth 1 -type d | while read -r dir; do
    playlist_name="$(basename "$dir")"
    playlist_path="$PLAYLIST_DIR/$playlist_name.m3u"

    # Find all supported audio files and write their relative paths to the playlist
    find "$dir" -type f \( -iname "*.mp3" -o -iname "*.flac" -o -iname "*.ogg" \) \
        | sed "s|$MUSIC_DIR/||" > "$playlist_path"
    
    echo "Created playlist: $playlist_name"
done

# Update MPD database if needed
mpc update
