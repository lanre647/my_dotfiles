#!/data/data/com.termux/files/usr/bin/bash

# --- CONFIG ---
ACCESS_KEY="RbM4djWIkYLq37H3rVcz7p7LubozCQBErL5yp3EZOrM"
SAVE_PATH="$HOME/wallpaper.jpg"
TARGET_LAT=6.5244   # Update these!
TARGET_LON=3.3792
THRESHOLD=0.5       # 500 meters

# 1. Get Location
LOC=$(termux-location -p last)
CUR_LAT=$(echo "$LOC" | grep -oP '(?<="latitude": )[^,]+')
CUR_LON=$(echo "$LOC" | grep -oP '(?<="longitude": )[^,]+')

# Calculate Distance
DIST=$(echo "awk 'BEGIN {
   lat1=$CUR_LAT; lon1=$CUR_LON; lat2=$TARGET_LAT; lon2=$TARGET_LON;
   PI=3.14159265; R=6371;
   dlat=(lat2-lat1)*PI/180; dlon=(lon2-lon1)*PI/180;
   a=sin(dlat/2)^2 + cos(lat1*PI/180)*cos(lat2*PI/180)*sin(dlon/2)^2;
   c=2*atan2(sqrt(a),sqrt(1-a));
   print R*c }'" | sh)

# 2. Decide Vibe & Volume
IS_AT_WORK=$(echo "$DIST <= $THRESHOLD" | bc -l)

if [ "$IS_AT_WORK" -eq 1 ]; then
    QUERY="minimalist,productivity"
    termux-volume ring 0
    MSG="Focus Mode Active 🎯"
else
    # Default Time-Based Logic
    HOUR=$(date +%H)
    termux-volume ring 10
    if [ "$HOUR" -ge 5 ] && [ "$HOUR" -lt 9 ]; then QUERY="sunrise";
    elif [ "$HOUR" -ge 9 ] && [ "$HOUR" -lt 17 ]; then QUERY="landscape";
    elif [ "$HOUR" -ge 17 ] && [ "$HOUR" -lt 21 ]; then QUERY="sunset";
    else QUERY="night,stars"; fi
    MSG="Free Mode: $QUERY"
fi

# 3. Fetch & Update Wallpaper
URL="https://api.unsplash.com/photos/random?query=$QUERY&orientation=portrait&client_id=$ACCESS_KEY"
IMG=$(curl -s "$URL" | grep -oP '(?<="raw":")[^"]+')

if [ -n "$IMG" ]; then
    curl -s "${IMG}&w=1440&h=2560&fit=crop" -o "$SAVE_PATH"
    termux-wallpaper -f "$SAVE_PATH"
    termux-wallpaper -l "$SAVE_PATH"
    termux-toast -b "#000000" -c "#FFFFFF" "$MSG"
fi
