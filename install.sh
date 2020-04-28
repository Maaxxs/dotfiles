#!/bin/bash

set -e

packages=()

# Looking for package manager
if command -v pacman 1>/dev/null; then
  installer='pacman -Sy'
elif command -v apt 1>/dev/null; then
  installer='apt install'
elif command -v dnf 1>/dev/null; then
  installer='dnf install'
  # This package provides `chsh` on fedora
  packages+=('util-linux-user')
elif command -v eopkg 1>/dev/null; then
  installer='eopkg install'
fi


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

if ! command -v curl 1>/dev/null; then
  packages+=('curl')
fi

if ! command -v most 1>/dev/null; then
  packages+=('most')
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

# 1: true, 0: false
INSTALL_SOURCE_CODE_PRO=0

if [ $INSTALL_SOURCE_CODE_PRO -eq 1 ]; then
    # Install patched font "Source Code Pro"
    echo "Downloading Source Code Pro. This might take a while"
    mkdir -p $HOME/.local/share/fonts/SourceCodePro
    cd $HOME/.local/share/fonts/SourceCodePro
    latest_version=$(curl -s https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest | grep "browser_download_url" | grep "SourceCodePro.zip" | awk '{ print $2 }' | tr -d \")
    wget --quiet $latest_version
    echo "Setting Source Code Pro as default monospace font"
    unzip SourceCodePro.zip
    fc-cache -f
    rm -f SourceCodePro.zip
    gsettings set org.gnome.desktop.interface monospace-font-name 'SauceCodePro Nerd Font 10'
    cd
fi



