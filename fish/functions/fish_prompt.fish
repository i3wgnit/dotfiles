switch $USER
case waigni
    function twl_get_Prompt
        set_color white
        echo -n 'w'
        set_color BCBCBC
        echo -n 'a'
        set_color 8A8A8A
        echo -n 'i'
        set_color 5FD7FF
        echo -n 'g'
        set_color 00D7FF
        echo -n 'n'
        set_color 00AFFF
        echo -n 'i'
    end
case root
    function twl_get_Prompt
        set_color red
        echo -n '[root]'
    end

case '*'
    function twl_get_Prompt
        echo -n $User
    end
end

function fish_prompt
    twl_get_Prompt
    set_color white --bold
    echo -n ' '(basename (prompt_pwd))' '
    set_color normal

    set -q RANGER_LEVEL
    and echo -n "[ranger] "

    set -q SSH_TTY
    and echo -n "(ssh) "
end

