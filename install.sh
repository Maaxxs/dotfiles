#!/bin/bash

cp bashrc ~/.bashrc
cp bash_aliases ~/.bash_aliases

power = read "Install powerline-shell[y] with pip or just copy json file?[n]"
if [ power -eq "y" || power -eq "Y" ]
then
    sudo pip install powerline-shell
fi 
cp powerline-shell.json ~/.powerline-shell.json

# install vim-plug for neovim
nvim = read "Install Plug for NeoVim? [y/n]"
if [ nvim -eq "y" || nvim -eq "Y"]
then
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dir https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# neovim configuration
mkdir -p ~/.config/nvim/
cp config/nvim/init.vim ~/.config/nvim/init.vim

mkdir -p ~/.config/conky/
cp config/conky/archlinux.png ~/.config/conky/
# for desktop computer
cp config/conky/conky.conf ~/.config/conky/
cp config/conky/conky2.conf ~/.config/conky/

# for laptop
# cp config/conky/conky-laptop.conf ~/.config/conky/





