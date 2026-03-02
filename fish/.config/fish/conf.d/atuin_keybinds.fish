function _atuin_bindings --on-event fish_postexec
    bind \cr _atuin_search
end

if status --is-interactive
    # Insert mode
    bind -M insert \e\[A history-search-backward
    bind -M insert \e\[B history-search-forward

    # Normal mode
    bind -M default \e\[A history-search-backward
    bind -M default \e\[B history-search-forward
end
