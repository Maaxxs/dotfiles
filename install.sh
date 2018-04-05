#!/bin/bash

cp bashrc ~/.bashrc
cp bash_aliases ~/.bash_aliases

sudo pip install powerline-shell
cp powerline-shell.json ~/.powerline-shell.json

# install vim-plug for neovim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dir https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# neovim configuration
cp config/nvim/init.vim ~/.config/nvim/init.vim --create-dir

cp config/conky/archlinux.png ~/.config/conky/ --create-dir
# for desktop computer
cp config/conky/conky.conf ~/.config/conky/
cp config/conky/conky2.conf ~/.config/conky/

# for laptop
# cp config/conky/conky-laptop.conf ~/.config/conky/





