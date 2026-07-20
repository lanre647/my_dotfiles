#!/bin/bash

updates=$(checkupdates 2>/dev/null | wc -l)

if [ "$updates" -eq 0 ]; then
    echo '{"text":"","tooltip":"System up to date","class":"ok"}'
else
    echo "{\"text\":\"󰚰 $updates\",\"tooltip\":\"$updates updates available\",\"class\":\"updates\"}"
fi
