#!/data/data/com.termux/files/usr/bin/bash

# --- CONFIG ---
ACCESS_KEY="RbM4djWIkYLq37H3rVcz7p7LubozCQBErL5yp3EZOrM"
SAVE_PATH="$HOME/wallpaper.jpg"
LOG_FILE="$HOME/wallpaper.log"
HOUR=$(date +%H)

# 1. Determine Query
if [ "$HOUR" -ge 5 ] && [ "$HOUR" -lt 9 ]; then QUERY="sunrise,mist";
elif [ "$HOUR" -ge 9 ] && [ "$HOUR" -lt 17 ]; then QUERY="architecture,minimal";
elif [ "$HOUR" -ge 17 ] && [ "$HOUR" -lt 21 ]; then QUERY="sunset,cyan";
else QUERY="dark,abstract,black"; fi

# 2. Fetch Data (Extracting both Image URL and the Dominant Color)
RESPONSE=$(curl -s "https://api.unsplash.com/photos/random?query=$QUERY&orientation=portrait&client_id=$ACCESS_KEY")

IMG_URL=$(echo "$RESPONSE" | grep -oP '(?<="raw":")[^"]+')
DOMINANT_COLOR=$(echo "$RESPONSE" | grep -oP '(?<="color":")[^"]+')

if [ -z "$IMG_URL" ]; then
    echo "[$(date)] API Error" >> "$LOG_FILE"
    exit 1
fi

# 3. Download and Apply
curl -s "${IMG_URL}&w=1080&h=1920&fit=crop" -o "$SAVE_PATH"
termux-wallpaper -f "$SAVE_PATH"
termux-wallpaper -l -f "$SAVE_PATH"

# 4. The "Impressive" Feedback
# Show a toast with the hex code as the background color of the toast!
termux-toast -b "$DOMINANT_COLOR" -c "#FFFFFF" "Palette Updated: $DOMINANT_COLOR"

# Output a color block to the terminal
echo -e "\n  \e[48;2;$(printf "%d;%d;%d" 0x${DOMINANT_COLOR:1:2} 0x${DOMINANT_COLOR:3:2} 0x${DOMINANT_COLOR:5:2})m      \e[0m New Wallpaper Color: $DOMINANT_COLOR"
echo "[$NOW] SUCCESS: Set $QUERY ($DOMINANT_COLOR)" >> "$LOG_FILE"
