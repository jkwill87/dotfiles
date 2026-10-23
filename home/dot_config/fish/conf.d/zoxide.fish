if not status is-interactive
    return
end

if type -q zoxide
    zoxide init fish | source
end

