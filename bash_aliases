# get alias to work on root
alias sudo='sudo '


# git alias
alias gss='git status'
alias gm='git commit'
alias ga='git add *'
alias gpull='git pull origin master'
alias gpush='git push -u origin master'


# ls alias
alias ls='ls --color=auto'
alias ll='ls -lahF'

# manpages
# requires package 'most'
alias man='man -P most'


# neovim
alias v='nvim'
alias vi='nvim'
alias vim='nvim'


# Updating system
alias up='trizen -Syyu'
alias s='trizen -Ss'        # search package official and AUR
alias i='trizen -S'         # install package official and AUR
alias u='trizen -Runs'
alias q='trizen -Qi'

# grep
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'


# youtube-dl
alias dl='youtube-dl --audio-format mp3 --extract-audio -o "%(title)s.%(ext)s"'


