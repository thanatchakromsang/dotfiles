#!/usr/bin/bash
[ "$(hostname)" == "sertis" ] && export LID=LID0
[ "$(hostname)" == "thinkpad" ] && export LID=LID

if grep -q open /proc/acpi/button/lid/$LID/state; then
    swaymsg output eDP-1 enable
else
    swaymsg output eDP-1 disable
fi
