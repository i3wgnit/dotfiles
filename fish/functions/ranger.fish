# Allows for using ranger as cd
function ranger
    if test -z "$RANGER_LEVEL"
        set tempfile (mktemp -t tmp.XXXXXX)
        trap 'rm -f -- "$tempfile"' EXIT
        eval $HOME'/bin/ranger --choosedir="$tempfile" ""(test -z "$argv"; and echo (pwd); or echo $argv)""'
        test -f "$tempfile"
        and if test (cat -- "$tempfile") != (pwd)
            cd (cat -- "$tempfile")
        end
    else
        exit
    end
end

