#!/bin/sh

cap=$(cat /sys/class/power_supply/BAT0/capacity)
stat=$(cat /sys/class/power_supply/BAT0/status)

if [ "$stat" = "Charging" ]; then
    icon="󰂄"
elif [ "$cap" -ge 90 ]; then
    icon="󰁹"
elif [ "$cap" -ge 75 ]; then
    icon="󰂀"
elif [ "$cap" -ge 60 ]; then
    icon="󰁿"
elif [ "$cap" -ge 45 ]; then
    icon="󰁾"
elif [ "$cap" -ge 30 ]; then
    icon="󰁽"
elif [ "$cap" -ge 15 ]; then
    icon="󰁻"
else
    icon="󰁺"
fi

printf "%s %s%%" "$icon" "$cap"
