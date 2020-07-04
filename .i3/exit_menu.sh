#!/bin/bash
[ $(echo -e 'NO\nYES' | dmenu -sb '#ff6600' -fn \ '-*-*-*-*-*-*-20-*-*-*-*-*-*-*' -i -p "Do you really want to exit? This will end your session.") = "YES" ] && i3-msg exit
