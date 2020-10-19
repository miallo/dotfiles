#!/bin/sh
[ $(echo -e 'NO\nYES' | dmenu -sb '#ff6600' -fn \ '-*-*-*-*-*-*-20-*-*-*-*-*-*-*' -i -p "Do you really want to shut down?") = "YES" ] && shutdown -h now
