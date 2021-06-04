#!/bin/bash

# Create backup of configuration files if they exist
configuration_files=(
    "~/.zshrc"
    "~/.tmux.conf"
    "~/.config/nvim/init.vim"
    "~/.pam_environment"
    )

for file in ${configuration_files[@]}
do
    if [ -f $file ]
    then
        mv $file "$file.old"
    fi
done

# Put the zsh sources in place
printf "source $HOME/.dotfiles/.zshrc" > ~/.zshrc
printf "source $HOME/.dotfiles/.oh-my-zsh/custom/aliases.zsh" > ~/.oh-my-zsh/custom/aliases.zsh
printf "source $HOME/.dotfiles/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" > ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Load VimPlug at start of NeoVim
if [ ! -f ~/.local/share/nvim/site/autoload/plug.vim ]
then
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim 
fi
mkdir -p ~/.config/nvim/
printf "so $HOME/.dotfiles/.config/nvim/init.vim" > ~/.config/nvim/init.vim

# Vim
printf "so $HOME/.dotfiles/.vimrc" > ~/.vimrc

# Tmux
printf "source-file $HOME/.dotfiles/.tmux.conf" > ~/.tmux.conf

# Alacritty
mkdir $HOME/.config/alacritty
ln -sf $HOME/.dotfiles/.config/alacritty/alacritty.yml $HOME/.config/alacritty/alacritty.yml

# change default shell to zsh
echo '[*] Changing shell to zsh'
sudo chsh -s $(which zsh) $USER

echo "Link ~/.pam_environment to .dotfiles/.pam_environment"
ln -sf $HOME/.dotfiles/.pam_environment $HOME/.pam_environment

echo "Link ~/.config/i3/config to .dotfiles/.config/i3/config"
mkdir -p $HOME/.config/i3
ln -sf $HOME/.dotfiles/.config/i3/config $HOME/.config/i3/config

echo "Link ~/.config/polybar/config to .dotfiles/.config/polybar/config"
mkdir -p $HOME/.config/polybar
ln -sf $HOME/.dotfiles/.config/polybar/config $HOME/.config/polybar/config




