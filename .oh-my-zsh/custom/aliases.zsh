# alias to work on root
alias sudo='sudo '

# manpages
# requires package 'most'
alias man='man -P most'


# neovim
alias nvimconfig='nvim ~/.config/nvim/init.vim'
alias v='nvim'

# Updating system
alias up='trizen -Syyu'
alias s='trizen -Ss'        
alias si='trizen -Si'
alias i='trizen -S'        
alias u='trizen -Runs'
alias q='trizen -Qi'
alias pacs='pacman -Ss'

# System update for Elementary OS
alias eup='sudo apt update && sudo apt full-upgrade'
alias es='apt search'
alias esi='apt show'
alias ei='sudo apt install'


# grep
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'


# youtube-dl
alias dl='youtube-dl --audio-format mp3 --extract-audio -o "%(title)s.%(ext)s"'
