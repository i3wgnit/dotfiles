#!/bin/sh

if command -v realpath >/dev/null 2>&1 ; then
    REALPATH=realpath
elif command -v grealpath >/dev/null 2>&1 ; then
    REALPATH=grealpath
else
    echo Error: realpath command not found >&2
    exit 1
fi

export REALPATH

link() {
    SOURCE="$1"
    TARGET="$2"

    if [ -d "$TARGET" ] ; then
        TARGET="${TARGET}/$(basename "$SOURCE")"
    fi

    if [ -e "$SOURCE" ] ; then
        if ln -n -s "$SOURCE" "$TARGET" >/dev/null 2>&1 ; then
            MESSAGE="Created link"
        elif [ -L "$TARGET" ] ; then
            if [ "$("$REALPATH" "$SOURCE")" = "$("$REALPATH" "$TARGET")" ] ; then
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
link "$XDG_CONFIG_HOME"/shell/logout "$HOME"/.bash_logout
link "$XDG_CONFIG_HOME"/bash/bashrc "$HOME"/.bashrc
 
link "$XDG_CONFIG_HOME"/shell/profile "$XDG_CONFIG_HOME"/zsh/.zprofile
link "$XDG_CONFIG_HOME"/shell/logout "$XDG_CONFIG_HOME"/zsh/.zlogout
link "$XDG_CONFIG_HOME"/zsh/zshrc "$XDG_CONFIG_HOME"/zsh/.zshrc
link "$XDG_CONFIG_HOME"/zsh/zshenv "$HOME"/.zshenv

link "$XDG_DATA_HOME"/dotfiles/pyenv-virtualenv "$XDG_DATA_HOME"/pyenv/plugins

unset REALPATH
