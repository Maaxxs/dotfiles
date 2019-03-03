mv ~/.zshrc ~/.zshrc.old
mv ~/.tmux.conf ~/.tmux.conf.old
mv ~/.config/nvim/init.vim ~/.config/nvim/init.vim.old


printf "source $HOME/.dotfiles/.zshrc" > ~/.zshrc
printf "so $HOME/.dotfiles/.config/nvim/init.vim" > ~/.config/nvim/init.vim
printf "source-file $HOME/.dotfiles/tmux/tmux.conf" > ~/.tmux.conf
printf "source $HOME/.dotfiles/.oh-my-zsh/custom/aliases.zsh" > ~/.oh-my-zsh/custom/aliases.zsh
printf "source $HOME/.dotfiles/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" > ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh



