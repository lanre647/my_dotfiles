#!/data/data/com.termux/files/usr/bin/bash

# Clear for a fresh look
clear

# 1. Welcome (Fixed the uppercase bug using 'tr')
USER_NAME=$(whoami | tr '[:lower:]' '[:upper:]')
echo -e "\e[1;34m--- WELCOME BACK, $USER_NAME ---\e[0m"
date +"%A, %B %d, %Y | %H:%M:%S"
echo ""

# 2. Weather
echo -e "\e[1;32m[Weather Report]\e[0m"
curl -s "wttr.in?format=3"

# 3. Phone Vital Signs (Battery & Storage)
echo -e "\n\e[1;36m[Device Status]\e[0m"
# Extracting battery level via termux-battery-status (requires termux-api)
# Falling back to a simpler display if API isn't installed
if command -v termux-battery-status &> /dev/null; then
    BATT=$(termux-battery-status | grep percentage | awk -F: '{print $2}' | tr -d ' ,')
    echo "Battery: $BATT%"
else
    echo "Battery: (Install 'termux-api' app/pkg for stats)"
fi

# Storage check (Home directory)
STORAGE=$(df -h ~ | awk 'NR==2 {print $3 "/" $2 " used (" $5 ")"}')
echo "Storage: $STORAGE"

# 4. Daily Joke
echo -e "\n\e[1;33m[Daily Logic]\e[0m"
curl -s https://icanhazdadjoke.com/ -H "Accept: text/plain"
echo ""

# 5. Network Status
echo -e "\e[1;31m[Network Status]\e[0m"
echo "Public IP: $(curl -s ifconfig.me)"
echo "----------------------------"
