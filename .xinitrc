#!/bin/bash
[[ -f ~/.startup ]] && source ~/.startup &

#start wallpaper manager
~/.fehbg &

#set keyboard layout to US International
setxkbmap -layout 'us(intl)'

xbindkeys

exec i3 

