#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#PS1='[\u@\h \W]\$ '
PS1='[\W] > '

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

export EDITOR=nvim
export PATH="/home/max/scripts/:$PATH"
