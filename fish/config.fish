# == Setup ==
if not test -f "$HOME/.config/fish/.setup"
    set -U fish_greeting ''

    if test (uname -s) = 'Darwin'
        add_to_user_path /opt/local/bin /opt/local/sbin
    end

    add_to_user_path "$HOME/.pyenv/bin" "$HOME/bin"
    touch "$HOME/.config/fish/.setup"
end

# == Startup ==

# Start X at login
if status --is-login
    if test -z "$DISPLAY" -a $XDG_VTNR = 1
        exec startx -- -keeptty
    end
end

tput smkx

test -s "$HOME/.config/fish/shortcuts.fish"
and source "$HOME/.config/fish/shortcuts.fish"

test -s "$HOME/.config/fish/config.local.fish"
and source "$HOME/.config/fish/config.local.fish"

# Fish Vi-Mode
fish_vi_key_bindings ^ /dev/null

# pyenv
set -gx PYENV_ROOT "$HOME/.pyenv"

if status --is-interactive; and command -v pyenv >/dev/null 2>&1
    pyenv init - | source
    pyenv virtualenv-init - | source
end


# == Alias ==

# c/c++
abbr --add gcc99 'gcc -std=c99 -Wall'
abbr --add g++14 'g++ -std=c++14 -Wall'

# Reload config.fish
abbr --add so 'source ~/.config/fish/config.fish'
