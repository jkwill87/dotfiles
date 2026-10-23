if not status is-interactive
    return
end

if type -q starship
    starship init fish | source
end
