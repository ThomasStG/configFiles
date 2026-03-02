# Load all saved ssh keys
if status --is-interactive; and set -q SSH_AUTH_SOCK
    ssh-add --apple-load-keychain >/dev/null 2>&1
end

# Set the emoji width for iTerm
set -g fish_emoji_width 2

# Hide the fish greeting
set fish_greeting ""

# Use legacy fzf keybindings
set -g FZF_LEGACY_KEYBINDINGS 1

# Fish syntax highlighting
set -g fish_color_autosuggestion '555'  'brblack'
set -g fish_color_cancel -r
set -g fish_color_command --bold
set -g fish_color_comment red
set -g fish_color_cwd green
set -g fish_color_cwd_root red
set -g fish_color_end brmagenta
set -g fish_color_error brred
set -g fish_color_escape 'bryellow'  '--bold'
set -g fish_color_history_current --bold
set -g fish_color_host normal
set -g fish_color_match --background=brblue
set -g fish_color_normal normal
set -g fish_color_operator bryellow
set -g fish_color_param cyan
set -g fish_color_quote yellow
set -g fish_color_redirection brblue
set -g fish_color_search_match 'bryellow'  '--background=brblack'
set -g fish_color_selection 'white'  '--bold'  '--background=brblack'
set -g fish_color_user brgreen
set -g fish_color_valid_path --underline
set -g fish_key_bindings fish_vi_key_bindings

if status --is-interactive
    if type -q atuin
        atuin init fish | source
    end

    if type -q starship
        starship init fish | source
    end

    if type -q atuin
        atuin init fish | source
    end
end

if status --is-interactive; and type -q fnm
    fnm env --use-on-cd | source
end
