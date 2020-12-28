# == Setup ==
if not test -f "$HOME/.config/fish/.setup"
    set -U fish_greeting ''

    if test (uname -s) = 'Darwin'
        add_to_user_path /opt/local/bin /opt/local/sbin
    end

    add_to_user_path "$HOME/src/pyenv/bin" "$HOME/bin" "$HOME/.local/bin"
    touch "$HOME/.config/fish/.setup"
end

# == Startup ==

tput smkx

test -s "$HOME/.config/fish/shortcuts.fish"
and source "$HOME/.config/fish/shortcuts.fish"

test -s "$HOME/.config/fish/config.local.fish"
and source "$HOME/.config/fish/config.local.fish"

# Fish Vi-Mode
fish_vi_key_bindings ^ /dev/null

# pyenv
set -gx PYENV_ROOT "$HOME"/src/pyenv
if status --is-interactive; and command -v pyenv >/dev/null 2>&1
    pyenv init - | source
    pyenv virtualenv-init - | source
end

set -gx QT_QPA_PLATFORMTHEME 'qt5ct'

# stuff
set -gx XDG_CACHE_HOME "$HOME"/.cache
set -gx XDG_CONFIG_HOME "$HOME"/.config
set -gx XDG_DATA_HOME "$HOME"/.local/share

set -gx ASYMPTOTE_HOME "$XDG_CONFIG_HOME"/asy
set -gx DOCKER_CONFIG "$XDG_CONFIG_HOME"/docker
set -gx GNUPGHOME "$XDG_CONFIG_HOME"/gnupg
set -gx GTK2_RC_FILES "$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
set -gx LESSHISTFILE "$XDG_DATA_HOME"/less/history
set -gx NODE_REPL_HISTORY "$XDG_DATA_HOME"/node_repl_history
set -gx NUGET_PACKAGES "$XDG_CACHE_HOME"/NuGetPackages
set -gx OCTAVE_HISTFILE "$XDG_CACHE_HOME"/octave-hsts
set -gx OCTAVE_SITE_INITFILE "$XDG_CONFIG_HOME"/octave/octaverc
set -gx PULSE_COOKIE "$XDG_CACHE_HOME"/pulse_cookie
set -gx VIMINIT 'source '"$XDG_CONFIG_HOME"/vim/vimrc
set -gx WGETRC "$XDG_CONFIG_HOME"/wgetrc
abbr --add wget 'wget --hsts-file="$XDG_CACHE_HOME"/wget-hsts'
set -gx WINEPREFIX "$XDG_DATA_HOME"/wineprefixes/default
set -gx XAUTHORITY "$XDG_RUNTIME_DIR"/Xauthority
set -gx _JAVA_OPTIONS '-Djava.util.prefs.userRoot='"$XDG_CONFIG_HOME"/java

set -gx DOTNET_CLI_TELEMETRY_OPTOUT 1

# == Alias ==

# c/c++
abbr --add gcc99 'gcc -std=c99 -Wall'
abbr --add g++14 'g++ -std=c++14 -Wall'

# Reload config.fish
abbr --add so 'source ~/.config/fish/config.fish'

# Start X at login
if status --is-login
    if test -z "$DISPLAY" -a (tty) = /dev/tty1
        exec startx "$XDG_CONFIG_HOME"/X11/xinitrc
    end
end
