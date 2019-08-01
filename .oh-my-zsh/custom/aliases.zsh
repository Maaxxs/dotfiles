# alias to work on root
alias sudo='sudo '

# manpages
# requires package 'most'
alias man='man -P most'

# Updating system
if command -v trizen > /dev/null;
then
    alias up='trizen -Syyu'
    alias s='trizen -Ss'        
    alias si='trizen -Si'
    alias i='trizen -S'        
    alias u='trizen -Runs'
    alias q='trizen -Qi'
    alias pacs='pacman -Ss'
elif command -v pacman > /dev/null;
then
    alias up='sudo pacman -Syyu'
    alias s='pacman -Ss'        
    alias si='pacman -Si'
    alias i='sudo pacman -S'        
    alias u='sudo pacman -Runs'
    alias q='pacman -Qi'
elif command -v apt > /dev/null;
then
    alias up='sudo apt update && sudo apt dist-upgrade'
    alias s='apt search'        
    alias si='apt show'
    alias i='sudo apt install'        
    alias u='sudo apt purge && sudo apt autoremove'
    alias q='apt-cache show'
elif command -v dnf > /dev/null;
then
    alias up='sudo dnf upgrade'
    alias s='dnf search'
    alias si='dnf info'
    alias i='sudo dnf install'
    alias u='sudo dnf remove'
    alias q='dnf info'
elif command -v eopkg > /dev/null;
then
    alias up='sudo eopkg upgrade'
    alias s='eopkg search'
    alias si='eopkg info'
    alias i='sudo eopkg install'
    alias u='sudo eopkg remove'
    alias q='eopkg info'
fi


# neovim
alias sshconfig='nvim ~/.ssh/config'
alias nvimconfig='nvim ~/.config/nvim/init.vim'
alias dotnvim='nvim ~/.dotfiles/.config/nvim/init.vim'
alias v='nvim'


# grep
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'


# youtube-dl
alias dl='youtube-dl --audio-format mp3 --extract-audio -o "%(title)s.%(ext)s"'
