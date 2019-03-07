#!/bin/bash

set -e

# Looking for package manager
if command -v pacman 1>/dev/null; then
  installer='pacman -Sy'
elif command -v apt 1>/dev/null; then
  installer='apt install'
elif command -v dnf 1>/dev/null; then
  installer='dnf install'
fi

packages=()

if ! command -v git 1>/dev/null; then
  packages+=('git')
fi

if ! command -v tmux 1>/dev/null; then
  packages+=('tmux')
fi

if ! command -v zsh 1>/dev/null; then
  packages+=('zsh')
fi

if ! command -v nvim 1>/dev/null; then
  packages+=('neovim')
fi

if [ ${#packages[@]} -gt 0 ]; then
  sudo $installer ${packages[@]}
else 
  echo 'Needed packages are already installed.'
fi


# download oh-my-zsh and zsh-autosuggestions if not there yet
if [ ! -d ~/.oh-my-zsh ]; then
  echo 'Downloading oh-my-zsh and zsh-autosuggestions'
  git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh/
  git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
elif [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/ ]; then
  echo 'Downloading zsh-autosuggestions'
  git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
else 
  echo 'oh-my-zsh and zsh-autosuggestions are already there'
fi



