Dotfiles Quick Setup Guide
--------------------------

This bare repo contains dotfiles for the following:

* ZSH
* Neovim
* Tmux

## Installing on a New Machine

1. Ensure the following alias is active in the current shell:

        alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

2. Clone repo to new machine

        git clone --bare git@github.com:aaron-lucas/dotfiles.git $HOME/.dotfiles

3. Checkout dotfiles (existing dotfiles may need to be stashed/backed
   up/removed)

        dotfiles checkout

4. Ignore untracked files

        dotfiles config --local status.showUntrackedFiles no

## References

* [Hacker News](https://news.ycombinator.com/item?id=11070797)
* [Atlassian](https://www.atlassian.com/git/tutorials/dotfiles)
