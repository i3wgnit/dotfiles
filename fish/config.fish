# == Startup ==
set PATH ~/bin $PATH
set fish_greeting ""

# Start X at login
if status --is-login
    if test -z "$DISPLAY" -a $XDG_VTNR = 1
        startx -- -keeptty
    end
end

# Ranger level
test -n "$RANGER_LEVEL"; and set fish_greeting "in ranger"

# Powerline
source /usr/lib/python3.6/site-packages/powerline/bindings/fish/powerline-setup.fish
powerline-setup


# == Git ==
## fish git prompt
#set __fish_git_prompt_showdirtystate 'yes'
#set __fish_git_prompt_showstashstate 'yes'
#set __fish_git_prompt_showupstream 'yes'
#set __fish_git_prompt_color_branch yellow
#
## Status Chars
#set __fish_git_prompt_char_dirtystate '⚡'
#set __fish_git_prompt_char_stagedstate '→'
#set __fish_git_prompt_char_stashstate '↩'
#set __fish_git_prompt_char_upstream_ahead '↑'
#set __fish_git_prompt_char_upstream_behind '↓'
#
#function fish_prompt
#        set last_status $status
#        set_color $fish_color_cwd
#        printf '%s' (prompt_pwd)
#        set_color normal
#        printf '%s ' (__fish_git_prompt)
#       set_color normal
#end


# == Alias ==
# cd
alias ...='cd ../..'
alias ....='cd ../../..'

# VIM
alias v='vim'

# Ranger
alias ra='ranger'

# Reload config.fish
alias so='source ~/.config/fish/config.fish'

# Full system upgrade
alias pSyyu='pacaur --noconfirm -Syyu'

# xclip
alias xclip='xclip -selection c'

