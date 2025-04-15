alias cat="bat"
alias alist="arduino-cli board list"
alias alu='alist | fzf | awk "{print \$3}" | xargs -I {} arduino-cli board upload -p {} --fqbn arduino:avr:mega .'
alias ac='arduino-cli compile --fqbn arduino:avr:mega .'
alias acu='ac && alu'
alias gitc="git -h"
alias runc="build_and_run_cpp"
alias vimfz="fzf --tmux 80% --bind 'enter:become(nvim {})'"            # Center, 80% width and height
alias v="nvim"
alias pyvenv="~/PersonalProjects/python-venv.sh"
alias browse="links"
alias t="tmuxinator"
alias ts="tmuxinator start"
alias game="rungame"
alias reconnect="reconnect"
alias attach="tmuxattach"
alias cd="z"
alias g="bit"

# Define your list of commands
games=(
    "bastet"
    "typioca"
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
