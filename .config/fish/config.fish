#!/bin/fish

test -z "$XDG_CACHE_HOME"
    and set -gx XDG_CACHE_HOME "$HOME"/.cache
test -z "$XDG_CONFIG_HOME"
    and set -gx XDG_CONFIG_HOME "$HOME"/.config
test -z "$XDG_DATA_HOME"
    and set -gx XDG_DATA_HOME "$HOME"/.local/share

function source_if_exists
    test -s "$argv"
    and source "$argv"
end

source_if_exists "$XDG_CONFIG_HOME"/fish/env.fish

source_if_exists "$XDG_CONFIG_HOME"/shell/aliases
source_if_exists "$XDG_CONFIG_HOME"/shell/aliases.local
source_if_exists "$XDG_CONFIG_HOME"/fish/shortcuts.fish

# == Setup ==
if not test -f "$XDG_CONFIG_HOME"/fish/.setup
    set -U fish_greeting ''

    set -U fish_cursor_default block
    set -U fish_cursor_visual block
    set -U fish_cursor_insert line
    set -U fish_cursor_replace_one underscore

    if test (uname -s) = 'Darwin'
        add_to_user_path /opt/local/bin /opt/local/sbin
    end

    add_to_user_path "$PYENV_ROOT"/bin "$HOME"/.local/bin
    touch "$XDG_CONFIG_HOME"/fish/.setup
end

tput smkx

# vi mode
fish_vi_key_bindings ^ /dev/null
fish_vi_cursor

# == pyenv ==
if status --is-interactive; and command -v pyenv > /dev/null
    pyenv init - --no-rehash fish | source
    pyenv virtualenv-init - fish | source
end

# Start X at login
if status --is-login
    if test -z "$DISPLAY" -a (tty) = /dev/tty1
        exec startx "$XINITRC"
    end
end

function on_exit --on-process %self
    clear
end

source_if_exists "$XDG_CONFIG_HOME"/fish/config.local.fish
