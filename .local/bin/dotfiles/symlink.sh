#!/bin/sh

if command -v realpath >/dev/null; then
    REALPATH=realpath
elif command -v grealpath >/dev/null; then
    REALPATH=grealpath
else
    echo Error: realpath command not found
    exit 1
fi

export REALPATH

link() {
    SOURCE="$1"
    TARGET="$2"

    [ -d "$TARGET" ] \
        && TARGET="${TARGET}/$(basename "$SOURCE")"

    if [ -e "$SOURCE" ]; then
        if ln -n -s "$SOURCE" "$TARGET" >/dev/null 2>&1 ; then
            MESSAGE="Created link"
        elif [ -L "$TARGET" ]; then
            if [ "$("$REALPATH" "$SOURCE")" = "$("$REALPATH" "$TARGET")" ]; then
                MESSAGE="Link exists"
            else
                printf '%s already exists but is a symlink to a different file' "$TARGET"
                return
            fi
        else
            printf '%s already exists but is a regular file or directory\n' "$TARGET"
            return
        fi
    else
        MESSAGE="Nonexistent source"
    fi

    printf '%s %s -> %s\n' "$MESSAGE" "$SOURCE" "$TARGET"
}

link "$XDG_CONFIG_HOME"/shell/profile "$HOME"/.profile
link "$XDG_CONFIG_HOME"/shell/profile "$XDG_CONFIG_HOME"/zsh/.zprofile

link "$XDG_CONFIG_HOME"/shell/logout "$HOME"/.bash_logout
link "$XDG_CONFIG_HOME"/shell/logout "$XDG_CONFIG_HOME"/zsh/.zlogout

link "$XDG_CONFIG_HOME"/zsh/zshrc ~/.config/zsh/.zshrc

link "$XDG_DATA_HOME"/dotfiles/pyenv-virtualenv ~/.local/share/pyenv/plugins

unset REALPATH
