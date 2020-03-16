switch $USER
case waigni
    function _get_prompt_user
        set_color white
        printf 'w'
        set_color BCBCBC
        printf 'a'
        set_color 8A8A8A
        printf 'i'
        set_color 5FD7FF
        printf 'g'
        set_color 00D7FF
        printf 'n'
        set_color 00AFFF
        printf 'i'
    end
case root
    function _get_prompt_user
        set_color red
        printf '[root]'
    end

case '*'
    function _get_prompt_user
        printf '%s' "$USER"
    end
end

switch $TERM
case dumb
    function _get_prompt
        printf '[%s] %s ' "$USER" (basename (prompt_pwd))
    end
case '*'
    function _get_prompt
        _get_prompt_user
        set_color white --bold
        printf ' %s ' (basename (prompt_pwd))
        set_color normal
    end
end

function fish_prompt
    _get_prompt

    set -q RANGER_LEVEL
    and echo -n "[ranger] "

    set -q SSH_TTY
    and echo -n "(ssh) "
end

