#!/bin/bash
# Generate a timestamp for the filename
DATE=$(date +%Y%m%d_%H%M%S)
FILE="/sdcard/Download/INTRUDER_$DATE.jpg"

# 1. Take a stealthy photo (Front Camera = 1)
termux-camera-photo -c 1 "$FILE"

# 2. Add a little psychological warfare
termux-tts-speak "Intruder detected. Photo captured and uploaded."

# 3. Optional: Vibrate the phone to let them know they're caught
termux-vibrate -d 500
