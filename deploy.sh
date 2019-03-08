mv ~/.zshrc ~/.zshrc.old
mv ~/.tmux.conf ~/.tmux.conf.old
mv ~/.config/nvim/init.vim ~/.config/nvim/init.vim.old


# Put the zsh sources in place
printf "source $HOME/.dotfiles/.zshrc" > ~/.zshrc
printf "source $HOME/.dotfiles/.oh-my-zsh/custom/aliases.zsh" > ~/.oh-my-zsh/custom/aliases.zsh
printf "source $HOME/.dotfiles/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" > ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# NeoVim
if [ ! -f ~/.local/share/nvim/site/autoload/plug.vim ]; then
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim 
fi
mkdir -p ~/.config/nvim/
printf "so $HOME/.dotfiles/.config/nvim/init.vim" > ~/.config/nvim/init.vim

# Tmux
printf "source-file $HOME/.dotfiles/.tmux.conf" > ~/.tmux.conf



