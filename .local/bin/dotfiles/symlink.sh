#!/bin/sh

link() {
    SOURCE="$1"
    TARGET="$2"

    [ -d "$TARGET" ] \
        && TARGET="${TARGET}/$(basename "$SOURCE")"

    if [ -e "$SOURCE" ]; then
        if ln -s "$SOURCE" "$TARGET" >/dev/null 2>&1 ; then
            MESSAGE="Created link"
        elif [ -L "$TARGET" ]; then
            if [ "$(realpath "$SOURCE")" = "$(realpath "$TARGET")" ]; then
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

link ~/.config/bash/bashrc ~/.bashrc
link ~/.config/bash/bash_profile ~/.bash_profile

link ~/.local/share/dotfiles/pyenv-virtualenv ~/.local/share/pyenv/plugins
