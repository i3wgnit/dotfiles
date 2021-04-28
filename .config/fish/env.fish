#!/bin/fish

set -gx EDITOR 'vim'
set -gx VISUAL 'vim'
set -gx TERM 'st-256color'
set -gx BROWSER 'firefox'

set -gx QT_QPA_PLATFORMTHEME 'qt5ct'

# == asymptote ==
set -gx ASYMPTOTE_PSVIEWER 'zathura'
set -gx ASYMPTOTE_PDFVIEWER 'zathura'

# == pyenv ==
set -gx PYENV_ROOT "$XDG_DATA_HOME"/pyenv

# == clipmenu ==
set -gx CM_SELECTIONS 'clipboard'

# == stuff ==
set -gx ASYMPTOTE_HOME "$XDG_CONFIG_HOME"/asy
set -gx CHKTEXRC "$XDG_CONFIG_HOME"/chktex
set -gx CUDA_CACHE_PATH "$XDG_CACHE_HOME"/nv
set -gx DOCKER_CONFIG "$XDG_CONFIG_HOME"/docker
set -gx GNUPGHOME "$XDG_CONFIG_HOME"/gnupg
set -gx GTK2_RC_FILES "$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
set -gx LESSHISTFILE "$XDG_DATA_HOME"/less/history
set -gx NODE_REPL_HISTORY "$XDG_DATA_HOME"/node_repl_history
set -gx NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME"/npm/npmrc
set -gx NUGET_PACKAGES "$XDG_CACHE_HOME"/NuGetPackages
set -gx OCTAVE_HISTFILE "$XDG_CACHE_HOME"/octave-hsts
set -gx OCTAVE_SITE_INITFILE "$XDG_CONFIG_HOME"/octave/octaverc
set -gx PASSWORD_STORE_DIR "$XDG_DATA_HOME"/pass
set -gx PULSE_COOKIE "$XDG_RUNTIME_HOME"/pulse_cookie
set -gx TERMINFO "$XDG_DATA_HOME"/terminfo
set -gx TERMINFO_DIRS "$XDG_DATA_HOME"/terminfo:/usr/share/terminfo
set -gx TEXMFCONFIG "$XDG_CONFIG_HOME"/texlive/texmf-config
set -gx TEXMFHOME "$XDG_DATA_HOME"/texmf
set -gx TEXMFVAR "$XDG_CACHE_HOME"/texlive/texmf-var
set -gx VIMINIT 'source '"$XDG_CONFIG_HOME"/vim/vimrc
set -gx WGETRC "$XDG_CONFIG_HOME"/wgetrc
set -gx WINEPREFIX "$XDG_DATA_HOME"/wineprefixes/default
set -gx XAUTHORITY "$XDG_RUNTIME_DIR"/Xauthority
set -gx XINITRC "$XDG_CONFIG_HOME"/X11/xinitrc
set -gx _JAVA_OPTIONS '-Djava.util.prefs.userRoot='"$XDG_CONFIG_HOME"/java

set -gx DOTNET_CLI_TELEMETRY_OPTOUT 1
set -gx _JAVA_AWT_WM_NONREPARENTING 1
