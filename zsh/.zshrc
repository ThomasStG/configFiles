if [[ ! -f ~/.config/zsh/.zshrc.zwc || ~/.config/zsh/.zshrc -nt ~/.config/zsh/.zshrc.zwc ]]; then
    zcompile ~/.zshrc ~/.zshrc.zwc
fi
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

PATH="/Library/Frameworks/Python.framework/Versions/3.10/bin:${PATH}"
eval "$(/opt/homebrew/bin/brew shellenv)"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
alias mysql='/usr/local/mysql/bin/mysql -u root -p'
export NODE_PATH='/usr/local/lib/node_modules';
export EDITOR='nvim'
export STM32_PRG_PATH=/Applications/STMicroelectronics/STM32Cube/STM32CubeProgrammer/STM32CubeProgrammer.app/Contents/MacOs/bin
export FZF_DEFAULT_OPTS="--bind 'esc:toggle-preview'"
export LC_ALL=en_IN.UTF-8
export LANG=en_IN.UTF-8
export NVM_DIR="$HOME/.nvm"
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
source ~/.zsh-defer/zsh-defer.plugin.zsh

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
zsh-defer autoload -U zsh/terminfo  # Load terminal info for key bindings to work

HISTFILE=$HOME/.zhistory
SAVEHIST=5000
HISTSIZE=4999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

zsh-defer source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
zsh-defer source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
zsh-defer source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

bindkey "${terminfo[kcuu1]}" history-beginning-search-backward
bindkey "${terminfo[kcud1]}" history-beginning-search-forward

zsh-defer eval "$(zoxide init zsh)"
zsh-defer eval "$(thefuck --alias)"
zsh-defer eval $(thefuck --alias FUCK)
zsh-defer eval $(thefuck --alias f)

zsh-defer '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"'
zsh-defer '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"'

bindkey -v
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

zsh-defer source ~/.config/zsh/spotify.zsh
zsh-defer source ~/.config/zsh/yazi.zsh
zsh-defer source ~/.config/zsh/eza.zsh
zsh-defer source ~/.config/zsh/alias.zsh
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/bit bit
