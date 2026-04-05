#!/bin/bash

# --- CONFIGURATION ---
WHITELIST_FILE="$HOME/known_devices.txt"
SCAN_LOG="$HOME/last_scan.log"
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

# Check if whitelist exists, if not, create it with your current IP
if [ ! -f "$WHITELIST_FILE" ]; then
    echo "Creating whitelist..."
    ifconfig wlan0 | grep 'inet ' | awk '{print $2}' > "$WHITELIST_FILE"
    echo "Whitelist created with your IP. Add others to $WHITELIST_FILE"
fi

# Get Network Range
MY_IP=$(ifconfig wlan0 | grep 'inet ' | awk '{print $2}')
RANGE=$(echo $MY_IP | cut -d '.' -f 1-3)".0/24"

echo -e "${GREEN}[*] Scanning $RANGE...${NC}"

# Perform the scan and extract IPs
nmap -sn $RANGE | grep "Nmap scan report" | awk '{print $NF}' | tr -d '()' > "$SCAN_LOG"

# Compare Scan to Whitelist
INTRUDERS=0
while read -r detected_ip; do
    if ! grep -q "$detected_ip" "$WHITELIST_FILE"; then
        echo -e "${RED}[!] UNKNOWN DEVICE DETECTED: $detected_ip${NC}"
        
        # Trigger Android Notification
        termux-notification -t "⚠️ SECURITY ALERT" -c "Unknown device detected: $detected_ip" --priority high --vibrate 500
        
        ((INTRUDERS++))
    fi
done < "$SCAN_LOG"

if [ "$INTRUDERS" -eq 0 ]; then
    echo -e "${GREEN}[✓] Network secure. All devices recognized.${NC}"
fi
