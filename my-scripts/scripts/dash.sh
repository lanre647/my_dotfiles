#!/bin/bash
# dash.sh - Live Refreshing Banner

while true; do
    # Call your existing banner script
    bash ~/scripts/rbanner.sh
    
    # Wait 5 minutes (300 seconds)
    # You can change this to 60 for 1 minute
    sleep 300
done

