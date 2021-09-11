# dotfiles

To install my dotfiles, clone a bare copy of the repo to `$HOME/.dotfiles` and run the
following commands
```sh
dotf() {
    command git --git-dir="$HOME"/.dotfiles/ --work-tree="$HOME" "$@"
}

# fetch and checkout bare repository
dotf fetch
dotf checkout

# hide unsightly untracked files
dotf config status.showUntrackedFiles no

# unalias bootstrap function
unset dotf

# full sync
. $HOME/.config/shell/env
dotf sync
```

## Dependencies

- [st](https://gitlab.com/i3wgnit/st-twl)
- [dwm](https://gitlab.com/i3wgnit/dwm-twl)
  - [dwmblocks](https://gitlab.com/i3wgnit/dwmblocks-twl)
- dmenu
- pulseaudio
  - alsa
- fonts
  - ~~misc ohsnap~~
  - iosevka
  - ~~iosevka term~~
  - ~~iosevka nerd font~~
  - hermit
- gtk
  - papirus-icon-theme
  - xcursor-neutral++

### Optional

#### UI/UX

- file manager
  - spacefm
- image viewer
  - sxiv
- notifications
  - dunst
- redshift
- screenshot
  - maim
- shell
  - ~~fish shell~~
  - zsh
- torrent
  - transmission

#### Daemons

- auto-lock
  - xss-lock
  - gllock
- bluetooth
  - blueman
  - bluez
- cronjobs
  - fcron
- music player
  - mpd
  - ncmpcpp
- ntp
  - chrony
- tor
  - torbrowser
  - torsocks

#### Misc

- R
- emacs
- firefox
- gimp
- htop
- jack2
- krita
- latex
  - texlive
- mpv
- neofetch
- piper
- tmux
- ungoogled-chromium

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
