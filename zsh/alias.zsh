alias cat="bat"
alias alist="arduino-cli board list"
alias alu="arduino_upload"
alias ac="arduino_compile"
alias acu='ac && alu'
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

function arduino_upload() {
  alist | fzf | awk '{print $3}' | xargs -I{} arduino-cli upload -p {} --fqbn arduino:avr:$1 && echo "Uploading to $1"
}
function arduino_compile() {
  arduino-cli compile --fqbn arduino:avr:$1 .
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

function build_and_run_cpp(){
  g++ -std=c++20 -o ${1%.*} "$1" && ./${1%.*}
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
