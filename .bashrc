#
# ~/.bashrc
#

#Configure keychain for ssh-agent
eval $(keychain --confhost --noask --quiet --eval)

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#Load aliases
[[ -f ~/.alias ]] && source ~/.alias

#Infinite history
HISTSIZE= HISTFILESIZE= # Infinite history.

#PS1='[\u@\h \W]\$ '
export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"

test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors ~/.dircolors)" || eval "$(dircolors -b)"


