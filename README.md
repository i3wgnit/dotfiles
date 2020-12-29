# dotfiles

To install my dotfiles, clone a bare copy of the repo to `$HOME/.dotfiles` and run the
following command
```sh
dot() {
    command git --git-dir="$HOME"/.dotfiles/ --work-tree="$HOME" "$@"
}

dot checkout
dot config status.showUntrackedFiles no
```

## Dependencies

- [st](https://gitlab.com/i3wgnit/st-twl)
- [dwm](https://gitlab.com/i3wgnit/dwm-twl)
  - [dwm](https://gitlab.com/i3wgnit/dwmblocks-twl)
- dmenu
- fonts
  - misc ohsnap
  - iosevka
  - iosevka term
  - iosevka nerd font
  - hermit

### Optional

- R
- emacs
- dunst
- firefox
- fish shell
- htop
- latex
- mpv
- redshift
- torsocks

## TODO

- [x] add local customizations
  - [x] bash
  - [x] fish
  - [x] asymptote
  - ~~[ ] i3~~
  - [x] X11
- ~~[ ] customize git commands~~
- [x] switch to git bare repo
- [x] de-cluter home directory
- [x] switch to dwm
