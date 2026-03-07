function fish_should_add_to_history
    string match -rq '^\s*(exit|ls|cd|clear|pwd|history)\s*$' -- $argv[1]; and return 1
    return 0
end
