if status --is-interactive
    SHELL=/usr/bin/fish keychain --eval --quiet | source
end
