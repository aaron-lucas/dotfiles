# Use vi editing mode
# set -o vi

# Randomise prompt color in every shell
COLORCODE=$(($RANDOM % 7 + 1))
if [ $COLORCODE -eq 7 ]
then
    # For orange
    LIGHT='38;5;208'
    DARK='38;5;166'
else
    LIGHT="9$COLORCODE"
    DARK="3$COLORCODE"
fi

export PS1="\[\e[m\]\[\e[${DARK}m\]\u@\h\[\e[m\] \[\e[${LIGHT}m\]\W\[\e[m\] \\$ "
# export PS1="\[\e[38;5;245m\][\[\e[m\]\[\e[m\]\[\e[${DARK}m\]\u\[\e[m\]\[\e[38;5;245m\]@\[\e[m\]\[\e[${DARK}m\]\h\e[m\]\[\e[m\] \[\e[${LIGHT}m\]\W\[\e[m\]\[\e[38;5;245m\]]\[\e[m\]\\$ "

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

#GCC alias
alias gccc='gcc -Wall -Werror -O3 -std=c99'

# Clear alias
alias c='clear'

# Reload .bash_profile
alias src='source ~/.bash_profile'

# MATLAB CLI
alias matlab='/Applications/MATLAB_R2018b.app/bin/matlab -nodisplay'

# Manage dotfiles with git
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Alias to compile C++14 code
# alias comp='clang++ -std="c++14"'

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

# Setting PATH for Python 3.7
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"
export PATH
