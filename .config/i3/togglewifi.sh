#! /bin/sh

status=$(nmcli radio wifi)
if [ $status = "enabled" ] ; then
    notify-send -i network-wireless-none "wireless disabled"
    nmcli radio wifi off
else
    notify-send -i network-wireless-none "wireless enabled"
    nmcli radio wifi on
fi

exit 0
