alias sp "spotify play/pause >/dev/null"
alias sb "spotify previous >/dev/null"
alias sn "spotify next >/dev/null"
alias sj "spotify jump >/dev/null"
alias si "spotify info"
alias sf "spotify forward >/dev/null"
alias sr "spotify rewind >/dev/null"
alias ss "toggle_spotify_shuffle >/dev/null"

alias DownloadSpotify download_spotify

function toggle_spotify_shuffle
    set current_state (spotify info | grep 'Shuffle is' | awk '{print $3}')

    if test "$current_state" = "on."
        spotify shuffle off
    else
        spotify shuffle on
    end
end

function download_spotify
    set url $argv[1]
    set start_time $argv[2]
    set end_time $argv[3]

    set output "$HOME/Downloads/%(title)s.%(ext)s"

    if test -z "$start_time"; and test -z "$end_time"
        # Full download
        yt-dlp --write-auto-subs -x --audio-format mp3 \
            --output $output $url

    else if test -n "$start_time"; and test -z "$end_time"
        # Start time only
        yt-dlp --write-auto-subs -x --audio-format mp3 \
            --output $output $url \
            --downloader ffmpeg \
            --downloader-args "ffmpeg_i:-ss $start_time"

    else
        # Start and end
        yt-dlp --write-auto-subs -x --audio-format mp3 \
            --output $output $url \
            --downloader ffmpeg \
            --downloader-args "ffmpeg_i:-ss $start_time -to $end_time"
    end
end

function playPlaylist
    command mpv "$HOME/SpotifyPlaylists/$argv[1]"
end
