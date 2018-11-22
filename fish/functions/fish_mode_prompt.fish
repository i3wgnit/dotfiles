function fish_mode_prompt
    switch $fish_bind_mode
    case default
        set_color --bold red
        echo '`'
    case visual
        set_color --bold blue
        echo '`'
    case replace_one
        set_color --bold green
        echo '`'
    case '*'
    end
end
