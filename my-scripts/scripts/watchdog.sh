#!/bin/bash
echo "Watchdog active... listening for wrong PINs."

# This scans the system log in real-time
logcat | grep --line-buffered "Password failure" | while read line
do
    echo "⚠️ Wrong PIN detected! Triggering camera..."
    ./intruder.sh
done
