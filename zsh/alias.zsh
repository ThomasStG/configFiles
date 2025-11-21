alias cat="bat"
alias alist="arduino-cli board list"
alias alu="arduino_upload"
alias ac="arduino_compile"
alias acu="arduino_compile_and_upload"
alias gitc="git -h"
alias runc="build_and_run_cpp"
alias vimfz="fzf --tmux 80% --bind 'enter:become(nvim {})'"            # Center, 80% width and height
alias v="nvim ./"
alias pyvenv="~/PersonalProjects/python-venv.sh"
alias browse="links"
alias tm="tmuxinator_list_presents"
alias ts="tmuxinator start"
alias game="rungame"
alias reconnect="reconnect"
alias attach="tmuxattach"
alias g="bit"
alias mysql='/usr/local/mysql/bin/mysql -u root -p'
alias c="z"
alias t="todo.sh"
alias mpcrp="resave_playlist"
alias mpcmp="make_playlist"
alias cheat="cheat"
alias weather="curl wttr.in/bow+NH"
alias ch="cheatshh"
alias wtf="wtfutil"
alias remote="ssh_connect"
alias at="arduino-cli upload -p /dev/tty.usbmodem14101 --fqbn arduino:avr:uno --verify"

function ssh_connect() {
  local host="10.200.200.$1:"
  ssh -L 8000:localhost:8000 -t thomas@"$host" 'TERM=xterm-256color zsh -l -c "clear; exec zsh"'
}

function arduino_compile() {
  arduino-cli compile --fqbn arduino:avr:$1 --output-dir build .
}

function arduino_upload() {
  local port=$(alist | fzf --query "A" | awk '{print $1}')
  local baud=${2:-9600}
  arduino-cli upload -p $port --fqbn arduino:avr:$1 --input-dir build \
    && echo "Uploaded to $port using $1" \
    && arduino-cli monitor -p $port --config baudrate=$baud
}

function arduino_compile_and_upload() {
  ac $1 && alu $1 $2
}

fzf_cmd_history() {
  local selected
  selected=$(command cat ~/.zhistory | fzf) || return

  if [[ -n "$selected" ]]; then
    LBUFFER+="$selected"
    zle redisplay
  fi
}

zle -N fzf_cmd_history
bindkey '^F' fzf_cmd_history

function tmuxinator_list_presents() {
  selected_preset=$( tmuxinator list | tail -n +2 | tr ' ' '\n' | fzf)

  if [ -n "$selected_preset" ]; then
    tmuxinator start "$selected_preset"
  else
    echo "No preset selected."
  fi
}

# Define your list of commands
games=(
    "bastet"
    "typioca"
    "ttyper"
    "nethack"
    "nsnake"
    "ttysolitaire"
    "2048"
)

function rungame(){
    selected_game=$(printf "%s\n" "${games[@]}" | fzf)
    if [ -n "$selected_game" ]; then
        echo "Running: $selected_game"
        $selected_game
    else
        echo "No game selected."
    fi
}

function tmuxattach(){
  tmux attach -t "$(tmux ls | fzf | cut -d':' -f1)"
}

function reconnect() {
    sesh connect "$(sesh list | fzf)"
}

function build_and_run_cpp() {
  local src="$1"
  local out="${src%.*}"
  
  if g++ -std=c++26 -Wall -Wextra -O2 -o "$out.out" "$src"; then
    "./$out.out"
  else
    echo "Build failed!"
  fi
}

function resave_playlist() {
  mpc rm "$1"
  mpc clear
  mpc add "$2"
  mpc save "$1"
}

function make_playlist() {
  mpc clear
  mpc add "$1"
  mpc save "$2"
}

function cheat() {
  curl cheat.sh/"$1"
}
