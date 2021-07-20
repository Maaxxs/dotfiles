# alias to work on root
alias sudo='sudo '

# manpages
# requires package 'most'
# alias man='man -P most'

# Updating system
if command -v yay > /dev/null;
then
    alias up='yay -Syu'
    alias s='yay -Ss'        
    alias si='yay -Si'
    alias i='yay -S'        
    alias u='yay -Runs'
    alias q='yay -Qi'
    alias pacs='pacman -Ss'
elif command -v trizen > /dev/null;
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
alias vim='nvim'


# grep
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Exa
if command -v exa > /dev/null;
then
    alias l='exa --git'
    alias ll='exa -l --git'
    alias la='exa -la --git'
else
    alias l='ls'
    alias ll='ls -l'
    alias la='ls -la'
fi

if command -v ip  > /dev/null;
then
    alias ipa='ip -c addr'
    alias ipr='ip -c route'
    alias ipr6='ip -c -6 route'
fi

# view file from terminal and open it with associated mime type
alias v='function _xdg-open() {
        xdg-open $1 2&>/dev/null &
    };
    _xdg-open'

# Get ext4 FileSystem Creation Date (fscd)
alias fscd='function _fscd() { 
    FILESYSTEM=$(mount | grep "/ type ext4" | cut -d " " -f 1); 
    CREATION_DATE=$(sudo tune2fs -l "$FILESYSTEM" | grep "Filesystem created");
    echo "$FILESYSTEM - $CREATION_DATE"; };
    _fscd'

# youtube-dl
alias dl='youtube-dl --audio-format mp3 --extract-audio -o "%(title)s.%(ext)s"'

# clipboard with X
# make clipboard the default (usually this is `primary` which is pasted via middleclick
alias xclip='xclip -selection clipboard'
alias news='newsboat'
alias duh='du -md1 2>/dev/null | sort -g'

