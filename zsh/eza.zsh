alias lss="eza --tree --level=1 --group-directories-first --no-permissions --git --ignore-glob='node_modules|\.DS_Store|\.localized|\.CFUserTextEncoding|.*-lock\.json|\.lesshst|.*_history|.*_histfile' --color=always --no-filesize --icons=always --no-time"
function list_home() {
  if [[ "$PWD" == "$HOME" ]]; then
    lss
  else
    eza --group-directories-first --no-permissions --git --ignore-glob="node_modules|\.ds_store|\.localized|\.cfusertextencoding|.*-lock\.json|\.lesshst|.*_history|.*_histfile" --tree --color=always --no-filesize --icons=always --no-time
  fi
}

alias ls="list_home"

alias lsf="eza -1 --level=1 --no-permissions --git --ignore-glob='node_modules|\.DS_Store|\.localized|\.CFUserTextEncoding|.*-lock\.json|\.lesshst|.*_history|.*_histfile' --color=always --no-filesize --icons=always --no-time --only-files"
alias lsd="eza --level=1 -D --tree"
