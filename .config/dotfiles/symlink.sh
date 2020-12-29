#!/bin/sh

link() {
    if ln -s "$1" "$2" >/dev/null 2>&1 ; then
        echo Created link "$1" '->' "$2"
    else
        echo Link exists "$1" '->' "$2"
    fi
}

link ~/.config/bash/bashrc ~/.bashrc
link ~/.config/bash/bash_profile ~/.bash_profile

link ~/.local/share/dotfiles/pyenv-virtualenv ~/.local/share/pyenv/plugins/
