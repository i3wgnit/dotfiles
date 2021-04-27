# dotfiles

To install my dotfiles, clone a bare copy of the repo to `$HOME/.dotfiles` and run the
following commands
```sh
dot() {
    command git --git-dir="$HOME"/.dotfiles/ --work-tree="$HOME" "$@"
}

# fetch and checkout bare repository
dot fetch
dot checkout

# hide unsightly untracked files
dot config status.showUntrackedFiles no

# unalias bootstrap function
unset dot

# full sync
~/.local/bin/dot sync
```

## Dependencies

- [st](https://gitlab.com/i3wgnit/st-twl)
- [dwm](https://gitlab.com/i3wgnit/dwm-twl)
  - [dwmblocks](https://gitlab.com/i3wgnit/dwmblocks-twl)
- dmenu
- fonts
  - ~~misc ohsnap~~
  - iosevka
  - ~~iosevka term~~
  - ~~iosevka nerd font~~
  - hermit

### Optional

- R
- dunst
- emacs
- firefox
- ~~fish shell~~
- htop
- latex
- mpv
- redshift
- torsocks
- zsh

## TODO

- [x] add local customizations
  - [x] bash
  - [x] fish
  - [x] asymptote
  - [ ] ~~i3~~
  - [x] X11
- [ ] ~~customize git commands~~
- [x] switch to git bare repo
- [x] de-cluter home directory
- [x] switch to dwm
