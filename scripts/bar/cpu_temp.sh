#!/bin/sh

t=$(sensors | grep "Package id 0:" | head -n1 | awk '{print $4}' | tr -d "+" | cut -d. -f1)
t=${t:-0}

if [ "$t" -ge 75 ]; then
    icon="🔥"
elif [ "$t" -ge 60 ]; then
    icon="⚠"
else
    icon=""
fi

printf "%s%s°C" "$icon" "$t"
