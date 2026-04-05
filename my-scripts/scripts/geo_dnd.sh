#!/data/data/com.termux/files/usr/bin/bash

# --- CONFIG ---
TARGET_LAT=6.5244   # Replace with your target Lat
TARGET_LON=3.3792   # Replace with your target Lon
THRESHOLD=0.5       # Distance in kilometers (0.5 = 500 meters)

# 1. Get Current Location (using GPS and Network)
# --last gives the most recent cached location to save battery
LOC=$(termux-location -p last)
CURRENT_LAT=$(echo "$LOC" | grep -oP '(?<="latitude": )[^,]+')
CURRENT_LON=$(echo "$LOC" | grep -oP '(?<="longitude": )[^,]+')

# 2. Haversine Formula (Math to calculate distance in KM)
# We use 'bc' for floating point math
DISTANCE=$(echo "awk 'BEGIN {
   lat1=$CURRENT_LAT; lon1=$CURRENT_LON; lat2=$TARGET_LAT; lon2=$TARGET_LON;
   PI=3.14159265; R=6371;
   dlat=(lat2-lat1)*PI/180; dlon=(lon2-lon1)*PI/180;
   a=sin(dlat/2)^2 + cos(lat1*PI/180)*cos(lat2*PI/180)*sin(dlon/2)^2;
   c=2*atan2(sqrt(a),sqrt(1-a));
   print R*c }'" | sh)

# 3. Logic: Silence or Sound
if (( $(echo "$DISTANCE <= $THRESHOLD" | bc -l) )); then
    termux-volume ring 0
    termux-toast "Focus Mode: Silenced (Distance: ${DISTANCE:0:4}km)"
else
    termux-volume ring 10
    # Only toast if we were recently silenced (optional)
fi
