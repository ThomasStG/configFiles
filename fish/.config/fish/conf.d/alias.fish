alias cat bat
alias alist "arduino-cli board list"
alias alu arduino_upload
alias ac arduino_compile
alias acu arduino_compile_and_upload
alias gitc "git -h"
alias runc build_and_run_cpp
alias vimfz "fzf --tmux 80% --bind 'enter:become(nvim {})'"
alias v "nvim ./"
alias pyvenv "~/PersonalProjects/python-venv.sh"
alias browse links
alias tm tmuxinator_list_presents
alias ts "tmuxinator start"
alias game rungame
alias reconnect reconnect
alias attach tmuxattach
alias g bit
alias mysql "/usr/local/mysql/bin/mysql -u root -p"
alias c z
alias t todo.sh
alias mpcrp resave_playlist
alias mpcmp make_playlist
alias cheat cheat
alias weather "curl wttr.in/bow+NH"
alias ch cheatshh
alias wtf wtfutil
alias remote ssh_connect
alias at "arduino-cli upload -p /dev/tty.usbmodem14101 --fqbn arduino:avr:uno --verify"
alias rrun run_r

function run_r
    set script $argv[1]
    set out plot.png

    Rscript -e "
        png('$out', width=800, height=600);
        source('$script');
        dev.off()
    "

    kitten icat $out
end

function ssh_connect
    set host "10.200.200.$argv[1]:"
    ssh -L 8000:localhost:8000 -t thomas@$host 'TERM=xterm-256color zsh -l -c "clear; exec zsh"'
end

function arduino_compile
    arduino-cli compile --fqbn arduino:avr:$argv[1] --output-dir build .
end

function arduino_upload
    set port (alist | fzf --query "A" | awk '{print $1}')
    set baud 9600
    if test -n "$argv[2]"
        set baud $argv[2]
    end

    arduino-cli upload -p $port --fqbn arduino:avr:$argv[1] --input-dir build \
        && echo "Uploaded to $port using $argv[1]" \
        && arduino-cli monitor -p $port --config baudrate=$baud
end

function arduino_compile_and_upload
    ac $argv[1]; and alu $argv[1] $argv[2]
end

function fzf_cmd_history
    set selected (cat ~/.zhistory | fzf)
    if test -n "$selected"
        commandline --insert $selected
    end
end

bind \cf fzf_cmd_history

function tmuxinator_list_presents
    set selected_preset (tmuxinator list | tail -n +2 | tr ' ' '\n' | fzf)

    if test -n "$selected_preset"
        tmuxinator start $selected_preset
    else
        echo "No preset selected."
    end
end

set games \
    bastet \
    typioca \
    ttyper \
    nethack \
    nsnake \
    ttysolitaire \
    2048

function rungame
    set selected_game (printf "%s\n" $games | fzf)
    if test -n "$selected_game"
        echo "Running: $selected_game"
        $selected_game
    else
        echo "No game selected."
    end
end

function build_and_run_cpp
    set src $argv[1]
    set out (string replace -r '\.[^.]*$' '' $src)

    if g++ -std=c++26 -Wall -Wextra -O2 -o "$out.out" $src
        ./"$out.out"
    else
        echo "Build failed!"
    end
end

function resave_playlist
    mpc rm $argv[1]
    mpc clear
    mpc add $argv[2]
    mpc save $argv[1]
end

function make_playlist
    mpc clear
    mpc add $argv[1]
    mpc save $argv[2]
end

function cheat
    curl cheat.sh/$argv[1]
end

alias ess "eza --tree --level=1 --group-directories-first --no-permissions --git --ignore-glob='node_modules|\.DS_Store|\.localized|\.CFUserTextEncoding|.*-lock\.json|\.lesshst|.*_history|.*_histfile' --color=always --no-filesize --icons=always --no-time"

function list_home
  if test "$PWD" = "$HOME"
    ess
  else
    eza --group-directories-first --no-permissions --git --ignore-glob="node_modules|\.ds_store|\.localized|\.cfusertextencoding|.*-lock\.json|\.lesshst|.*_history|.*_histfile" --tree --color=always --no-filesize --icons=always --no-time
  end
end

alias es "list_home"

alias ef "eza -1 --level=1 --no-permissions --git --ignore-glob='node_modules|\.DS_Store|\.localized|\.CFUserTextEncoding|.*-lock\.json|\.lesshst|.*_history|.*_histfile' --color=always --no-filesize --icons=always --no-time --only-files"
alias ed "eza --level=1 -D --tree"

alias ez 'find . -type f | sed "s|^\./||" | fzf | xargs -r nvim'
