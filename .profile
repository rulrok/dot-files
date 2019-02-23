#!/bin/bash
#Profile runs on login

[[ -f ~/.env ]] && source ~/.env

#Start i3 if not started already
[ $(tty) = "/dev/tty1" ] && ! pgrep -x i3 > /dev/null && exec startx

