#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#PS1='[\u@\h \W]\$ '
#PS1='[\W] \$ '
GREEN="\[$(tput setaf 2)\]"
RESET="\[$(tput sgr0)\]"
LIGHTBLUE='\e[0;96m'
PS1=$LIGHTBLUE'[\W] \$ '$RESET


if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Powerline shell
function _update_ps1() {
    PS1=$(powerline-shell $?)
}

if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

HISTSIZE=1000
export EDITOR=nvim
export PATH=$PATH:/$HOME/.local/bin

