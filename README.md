# vimrc
This is my vim configuration.
## Installation
Clone this and copy the vimrc file to `~/.vimrc`. Then:
### Clone Vundle
Run
```
$ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```
(Additional instructions can be found at https://linuxhint.com/vim-vundle-tutorial/.)
### Make Sure Your git config is alright
Messed up git installations might cause problems with line endings. Run 
```
$ git config --global core.autocrlf input
```
More details here: http://jjafuller.com/2017/06/2624/.
### Install Plugins in VIM
Run `:PluginInstall`. 
