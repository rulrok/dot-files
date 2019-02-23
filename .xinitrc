#!/bin/bash
[[ -f ~/.startup ]] && source ~/.startup &

#start wallpaper manager
~/.fehbg &

exec i3 

