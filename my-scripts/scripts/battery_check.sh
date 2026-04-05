#!/bin/bash
while true; do
  # Get battery level
  level=$(termux-battery-status | jq .percentage)
  
  if [ "$level" -ge 80 ]; then
    termux-tts-speak "Battery is at $level percent. Unplug me, dude."
    termux-notification -c "Unplug Charger!" --id battery_warn
    sleep 300 # Wait 5 mins before checking again
  fi
  sleep 60
done
