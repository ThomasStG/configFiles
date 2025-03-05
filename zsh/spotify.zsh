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
  if [ -z "$3" ]; then
    # If $3 is null, download with the second argument as the end time
    yt-dlp --write-auto-subs -x --audio-format "mp3" --output "$HOME/SpotifyPlaylists/$2/%(title)s.mp3" "$1"
  elif [ -z "$2" ]; then
    # If $2 is null, download the track with the end time as $3 or the default LikedSongs folder
    yt-dlp  --write-auto-subs --x --audio-format "mp3" --output "$HOME/SpotifyPlaylists/LikedSongs/%(title)s.mp3" "$1"
  else
    # Default case where neither $3 nor $2 is null
    yt-dlp  --write-auto-subs --x --audio-format "mp3" --output "$HOME/SpotifyPlaylists/$2/%(title)s.mp3" "$1" --downloader ffmpeg --downloader-args "ffmpeg_i:-ss 0 -to $3"
  fi
}

alias DownloadSpotify="download_spotify"
function playPlaylist(){
  mpv "$HOME/SpotifyPlaylists/$1"
}
alias mpv='playPlaylist' 

