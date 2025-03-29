# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc. Initialization code that may require console input (password prompts, [y/n] confirmations, etc.) must go above this block; everything else may go below.
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
export NODE_PATH='/usr/local/lib/node_modules';
export EDITOR='nvim'
# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba init' !!
export MAMBA_EXE="/Users/thomas/.micromamba/bin/micromamba";
export MAMBA_ROOT_PREFIX="/Users/thomas/micromamba";
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    if [ -f "/Users/thomas/micromamba/etc/profile.d/micromamba.sh" ]; then
        . "/Users/thomas/micromamba/etc/profile.d/micromamba.sh"
    else
        export  PATH="/Users/thomas/micromamba/bin:$PATH"  # extra space after export prevents interference from conda init
    fi
fi
unset __mamba_setup
# <<< mamba initialize <<<
if [ -f ~/.bash_profile ]; then . ~/.bash_profile;
fi

autoload -U compinit && compinit -C
zstyle ':completion:*' menu select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-rows-first true
zstyle ':completion:*' select-prompt '%SScrolling: %p/%l%s'
zmodload zsh/complist

# use the vi navigation keys in menu completion
bindkey -M menuselect '^[' send-break
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
# Bind Vim-like keys for menu navigation once the menuselect keymap is available
autoload -U zsh/terminfo  # Load terminal info for key bindings to work

export LC_ALL=en_IN.UTF-8
export LANG=en_IN.UTF-8
HISTFILE=$HOME/.zhistory
SAVEHIST=5000
HISTSIZE=4999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

bindkey "${terminfo[kcuu1]}" history-beginning-search-backward
bindkey "${terminfo[kcud1]}" history-beginning-search-forward
alias gitc="git -h"

source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
function build_and_run_cpp(){
  g++ -std=c++20 -o ${1%.*} "$1" && ./${1%.*}
}
alias runc="build_and_run_cpp"
eval "$(zoxide init zsh)"
alias cd="z"

eval $(thefuck --alias)
# You can use whatever you want as an alias, like for Mondays:
eval $(thefuck --alias FUCK)
eval $(thefuck --alias f)

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

bindkey -v
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
alias vimfz="fzf --tmux 80% --bind 'enter:become(nvim {})'"            # Center, 80% width and height
alias v="nvim"
alias pyvenv="~/PersonalProjects/python-venv.sh"
alias browse="links"
alias t="tmuxinator"
alias ts="tmuxinator start"

source ~/.config/zsh/spotify.zsh

source ~/.config/zsh/yazi.zsh

source ~/.config/zsh/eza.zsh

alias cat="bat"

# Define your list of commands
games=(
    "bastet"
    "typioca"
    "nethack"
    "nsnake"
    "ttysolitaire"
    "2048"
)

# Use fzf to select a command
alias game="rungame"

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

alias attach="tmuxattach"

function reconnect() {
    sesh connect "$(sesh list | fzf)"
}

alias reconnect="reconnect"

if [[ ! -f ~/.zshrc.zwc || ~/.zshrc -nt ~/.zshrc.zwc ]]; then
    zcompile ~/.zshrc ~/.zshrc.zwc
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export FZF_DEFAULT_OPTS="--bind 'esc:toggle-preview'"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true

