# if [[ ! -f ~/.zshrc.zwc || ~/.config/zsh/.zshrc -nt ~/.zshrc.zwc ]]; then
#     zcompile ~/.config/zsh/.zshrc ~/.zshrc.zwc
# fi
autoload -Uz compinit
if [[ -n "$HOME/.zcompdump" && -f "$HOME/.zcompdump" ]]; then
  zcompdump_age=$(( $(date +%s) - $(stat -f %m "$HOME/.zcompdump") ))
  if [[ $zcompdump_age -gt 86400 ]]; then  # Refresh after 1 day
    compinit
  else
    compinit -C
  fi
else
  compinit
fi
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc. Initialization code that may require console input (password prompts, [y/n] confirmations, etc.) must go above this block; everything else may go below.

PATH="/Library/Frameworks/Python.framework/Versions/3.10/bin:/Users/thomas/.local/bin:${PATH}"
eval "$(/opt/homebrew/bin/brew shellenv)"
export PYENV_ROOT="$HOME/.pyenv"
export TMUX_POWERLINE_STATUS_LEFT_LENGTH="60"
export TMUX_POWERLINE_STATUS_RIGHT_LENGTH="90"
export TODO_DB_PATH=$HOME/.config/td/todo.json
export PATH="$PYENV_ROOT/bin:$PATH:/Users/thomas/.cargo/bin"
export NODE_PATH='/usr/local/lib/node_modules';
export EDITOR='nvim'
export STM32_PRG_PATH=/Applications/STMicroelectronics/STM32Cube/STM32CubeProgrammer/STM32CubeProgrammer.app/Contents/MacOs/bin
export FZF_DEFAULT_OPTS="--bind 'esc:toggle-preview'"
export tree_user_command="eza --tree --level=1 --group-directories-first --no-permissions --git --ignore-glob='node_modules|\.DS_Store|\.localized|\.CFUserTextEncoding|.*-lock\.json|\.lesshst|.*_history|.*_histfile' --color=always --no-filesize --icons=always --no-time"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export NVM_DIR="$HOME/.nvm"
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
source ~/.zsh-defer/zsh-defer.plugin.zsh

zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} ma=0\;33
zstyle ':completion:*' list-rows-first true
zstyle ':completion:*' select-prompt '%SScrolling: %p/%l%s'
zmodload zsh/complist
bindkey '\e[Z' reverse-menu-complete

# use the vi navigation keys in menu completion
bindkey -M menuselect '^[' send-break
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
right_arrow() {
    zle forward-char
}
zle -N right_arrow
bindkey "^O" right_arrow
# Bind Vim-like keys for menu navigation once the menuselect keymap is available
zsh-defer autoload -U zsh/terminfo  # Load terminal info for key bindings to work
zsh-defer autoload -U tetriscurses

HISTFILE=$HOME/.zhistory
SAVEHIST=5000
HISTSIZE=4999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt inc_append_history   # append each command as you run it
unsetopt share_history      # don’t inject commands from other sessions immediately
setopt hist_verify
# Capture exit status of the last command
typeset -g LAST_STATUS=0

precmd() {
  LAST_STATUS=$?
}

zshaddhistory() {
  # $1 is the raw command line
  local cmd=$1
  # Modify it by appending the status code
  # Example: "ls -l" → "ls -l # [0]"
  print -r -- "$cmd # [$LAST_STATUS]"
  # Return nonzero to prevent the unmodified version from being added
  return 1
}

zsh-defer source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
zsh-defer source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
zsh-defer source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

bindkey "${terminfo[kcuu1]}" history-beginning-search-backward
bindkey "${terminfo[kcud1]}" history-beginning-search-forward

zsh-defer eval "$(zoxide init zsh)"
zsh-defer eval "$(jump shell)"
zsh-defer eval "$(thefuck --alias)"
zsh-defer eval $(thefuck --alias FUCK)
zsh-defer eval $(thefuck --alias f)

zsh-defer '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"'
zsh-defer '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"'

bindkey -v
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

tre() { command tre "$@" -e && source "/tmp/tre_aliases_$USER" 2>/dev/null; }

spf() {
    os=$(uname -s)

    # Linux
    if [[ "$os" == "Linux" ]]; then
        export SPF_LAST_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/superfile/lastdir"
    fi

    # macOS
    if [[ "$os" == "Darwin" ]]; then
        export SPF_LAST_DIR="$HOME/Library/Application Support/superfile/lastdir"
    fi

    command spf "$@"

    [ ! -f "$SPF_LAST_DIR" ] || {
        . "$SPF_LAST_DIR"
        rm -f -- "$SPF_LAST_DIR" > /dev/null
    }
}

zsh-defer source ~/.config/zsh/spotify.zsh
zsh-defer source ~/.config/zsh/yazi.zsh
zsh-defer source ~/.config/zsh/eza.zsh
zsh-defer source ~/.config/zsh/alias.zsh
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/bit bit

source /Users/thomas/.config/broot/launcher/bash/br
