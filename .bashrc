# If not running interactively, don't do anything
[[ $- == *i* ]] || return

# Use vi editing mode
# set -o vi

# # Randomise prompt color in every shell
# COLORCODE=$(($RANDOM % 7 + 1))
# if [ $COLORCODE -eq 7 ]
# then
#     # For orange
#     LIGHT='38;5;208'
#     DARK='38;5;166'
# else
#     LIGHT="9$COLORCODE"
#     DARK="3$COLORCODE"
# fi

# export PS1="\[\e[m\]\[\e[${DARK}m\]\u@\h\[\e[m\] \[\e[${LIGHT}m\]\W\[\e[m\] \\$ "
# # export PS1="\[\e[38;5;245m\][\[\e[m\]\[\e[m\]\[\e[${DARK}m\]\u\[\e[m\]\[\e[38;5;245m\]@\[\e[m\]\[\e[${DARK}m\]\h\e[m\]\[\e[m\] \[\e[${LIGHT}m\]\W\[\e[m\]\[\e[38;5;245m\]]\[\e[m\]\\$ "

LOGIN_COLOR="38;2;188;188;188"
PATH_COLOR="38;5;30;134;173"

COLOR_RED="\033[0;31m"
COLOR_YELLOW="\033[0;33m"
COLOR_GREEN="\033[0;32m"
COLOR_OCHRE="\033[38;5;95m"
COLOR_RESET="\033[0m"

function git_color {
    local git_status="$(git status 2> /dev/null)"

    if [[ ! $git_status =~ "working tree clean" ]]; then
        echo -e $COLOR_RED
    elif [[ $git_status =~ "Your branch is ahead of" ]]; then
        echo -e $COLOR_YELLOW
    elif [[ $git_status =~ "nothing to commit" ]]; then
        echo -e $COLOR_GREEN
    else
        echo -e $COLOR_OCHRE
    fi
}

function git_branch {
    local git_status="$(git status 2> /dev/null)"
    local on_branch="On branch ([^${IFS}]*)"
    local on_commit="HEAD detached at ([^${IFS}]*)"

    if [[ $git_status =~ $on_branch ]]; then
        local branch=${BASH_REMATCH[1]}
        echo " $branch"
    elif [[ $git_status =~ $on_commit ]]; then
        local commit=${BASH_REMATCH[1]}
        echo " $commit"
    fi
}

PS1="\[\e[m\]\[\e[${LOGIN_COLOR}m\]\u@\h\[\e[m\]:\[\e[${PATH_COLOR}m\]\W\[\e[m\]"
PS1+="\[\$(git_color)\]"
PS1+="\$(git_branch)"
PS1+="\[$COLOR_RESET\] › "
export PS1

# End of prompt customisation -------------------------------------------------

# Alias for thefuck
eval $(thefuck --alias)
alias fucking='sudo'

# Alias for NeoVim
alias oldvim='/usr/local/bin/vim'
alias vim='nvim'

#Enable colour support
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
eval $( dircolors -b $HOME/.dircolors )

# Aliases to automatically enable colour ouput for certain commands
alias ls="ls --color=always"
# alias grep="grep --color=always"
# alias egrep="egrep --color=always"

# Helpful ls shortcuts
alias la='ls -aGFh'
alias ll='ls -lGFh'

# Reload .bash_profile
alias src='source ~/.bash_profile'

# MATLAB CLI
alias matlab='/Applications/MATLAB_R2018b.app/bin/matlab -nodisplay'

# Manage dotfiles with git
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Man page coloring
export LESS_TERMCAP_mb=$(printf '\e[01;31m')
export LESS_TERMCAP_md=$(printf '\e[31m')
export LESS_TERMCAP_me=$(printf '\e[0m')
export LESS_TERMCAP_se=$(printf '\e[0m')
export LESS_TERMCAP_so=$(printf '\e[7;38;5;208m')
export LESS_TERMCAP_ue=$(printf '\e[0m')
export LESS_TERMCAP_us=$(printf '\e[04;93m')

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

source "$HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh"

alias tmux="TERM=screen-256color-bce tmux"
export TERM=xterm-256color

# Set editor as vim
export EDITOR=nvim

# Add python3.8 directory to path
export PATH="/usr/local/opt/python@3.8/bin:$PATH"

# Environment variable to /usr/bin/Cellar
export CELLAR='/usr/bin/Cellar'


# export JAVA_HOME=$(/usr/libexec/java_home -v 1.8.0)
