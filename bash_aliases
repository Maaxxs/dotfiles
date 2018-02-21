# Bash Aliases

# ls
alias ls='ls --color=auto'
alias ll='ls -laFh'

# system administration
alias up='trizen -Syyu'
alias s='pacman -Ss'
alias aurs='trizen -Ss'
alias i='trizen -S'
alias u='trizen -Runs'

# colored manpages
alias man='man -P most'

# grep
alias egrep='egrep --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'

# neovim
alias v='nvim'
alias vim='nvim'
alias vi='nvim'

# git
alias gss='git status'
alias ga='git add *'
alias gm='git commit'
alias gpull='git pull'
alias gpush='git push'

