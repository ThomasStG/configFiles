alias sp="spotify play/pause >/dev/null"
alias sb="spotify previous >/dev/null"
alias sn="spotify next >/dev/null"
alias sj="spotify jump >/dev/null"
alias si="spotify info"
alias sf="spotify forward >/dev/null"
alias sr="spotify rewind >/dev/null"
function toggle_spotify_shuffle() {
  current_state=$(spotify info | grep 'Shuffle is' | awk '{print $3}')
  if [ "$current_state" = "on." ]; then
    spotify shuffle off
  else
    spotify shuffle on
  fi
}
alias ss="toggle_spotify_shuffle >/dev/null"

function download_spotify() {
  local url="$1"
  local start_time="$2"
  local end_time="$3"

  if [ -z "$end_time" ] && [ -z "$start_time" ]; then
    # Only URL and folder provided → download full audio to that folder
    yt-dlp --write-auto-subs -x --audio-format "mp3" \
      --output "$HOME/Downloads/%(title)s.%(ext)s" "$url"

  elif [ -z "$end_time" ] && [ -n "$start_time" ]; then
    # URL, folder, and start_time provided → clip and save to folder
    yt-dlp --write-auto-subs -x --audio-format "mp3" \
      --output "$HOME/Downloads/%(title)s.%(ext)s" "$url" \
      --downloader ffmpeg --downloader-args "ffmpeg_i:-ss $start_time"

  else
    # URL, folder, and end_time provided → clip and save to folder
    yt-dlp --write-auto-subs -x --audio-format "mp3" \
      --output "$HOME/Downloads/%(title)s.%(ext)s" "$url" \
      --downloader ffmpeg --downloader-args "ffmpeg_i:-ss $start_time -to $end_time"
  fi
}

alias DownloadSpotify="download_spotify"
function playPlaylist(){
  mpv "$HOME/SpotifyPlaylists/$1"
}
alias mpv='playPlaylist' 

