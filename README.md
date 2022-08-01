Dotfiles Quick Setup Guide
--------------------------

This bare repo contains configurations for the following:

* ZSH/oh-mh-zsh
* Neovim
* Tmux
* iTerm (custom colorscheme only)

## Cloning on a New Machine

1. Ensure the following alias is active in the current shell:

        alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

2. Clone repo to new machine

        # With HTTPS
        git clone --bare https://github.com/aaron-lucas/dotfiles.git $HOME/.dotfiles

        # OR With SSH
        git clone --bare git@github.com:aaron-lucas/dotfiles.git $HOME/.dotfiles

3. Checkout dotfiles (existing dotfiles may need to be stashed/backed
   up/removed)

        dotfiles checkout

4. Ignore untracked files

        dotfiles config --local status.showUntrackedFiles no

## Additional Setup

### Install a Nerd Font

* Patched fonts with many symbols

* Pick from options at https://www.nerdfonts.com/font-downloads

### Neovim

* Install [Vim Plug](https://github.com/junegunn/vim-plug)

        sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

        # Install plugins in neovim with :PlugInstall

* Install `ccls` as C/C++ LSP for coc.nvim

        # E.g. with Homebrew
        brew install ccls

### ZSH

* Install [oh-my-zsh](https://ohmyz.sh/)

        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

* Restore `.zshrc`

        mv ~/.zshrc.pre-oh-my-zsh ~/.zshrc

* Note that the `$ZSH_CUSTOM` environment variable is changed from its default
  value of `~/.oh-my-zsh` to `~/.config/oh-my-zsh`.


### iTerm

* Import One Dark colorscheme (`~/.config/iterm2/One Dark.itermcolors`) in
  Profiles -> Colors settings

## References

* [Hacker News](https://news.ycombinator.com/item?id=11070797)
* [Atlassian](https://www.atlassian.com/git/tutorials/dotfiles)

