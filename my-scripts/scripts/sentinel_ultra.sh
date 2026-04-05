#!/bin/bash

# --- CONFIG ---
WHITELIST="$HOME/mac_whitelist.txt"
CACHE_FILE="$HOME/vendor_cache.txt"
GREEN='\033[0;32m'
RED='\033[0;31m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Ensure files exist
touch "$WHITELIST"
touch "$CACHE_FILE"

clear
echo -e "${CYAN}==================================================${NC}"
echo -e "${YELLOW}       SENTINEL ULTRA: NETWORK INTRUSION        ${NC}"
echo -e "${CYAN}==================================================${NC}"

# 1. Map the network
MY_IP=$(ifconfig wlan0 | grep 'inet ' | awk '{print $2}')
RANGE=$(echo $MY_IP | cut -d '.' -f 1-3)".0/24"
echo -e "${CYAN}[*] Mapping $RANGE...${NC}"
nmap -sn $RANGE > /dev/null

echo -e "Status  | IP Address      | Vendor / Brand"
echo -e "--------------------------------------------------"

# 2. Process devices
ip neighbor show | grep -E "REACHABLE|STALE|DELAY" | while read -r line; do
    IP=$(echo $line | awk '{print $1}')
    MAC=$(echo $line | awk '{print $5}')
    
    # Check Cache for Vendor to save time/bandwidth
    VENDOR=$(grep -i "$MAC" "$CACHE_FILE" | cut -d'|' -f2)
    
    if [ -z "$VENDOR" ]; then
        # Fetch from API if not in cache
        VENDOR=$(curl -s "https://api.macvendors.com/$MAC")
        # Handle API rate limits or errors
        if [[ "$VENDOR" == *"errors"* ]] || [ -z "$VENDOR" ]; then
            VENDOR="Unknown Vendor"
        else
            echo "$MAC|$VENDOR" >> "$CACHE_FILE"
        fi
    fi

    # Check Whitelist
    if grep -qi "$MAC" "$WHITELIST"; then
        printf "${GREEN}TRUSTED${NC} | %-15s | ${CYAN}%s${NC}\n" "$IP" "$VENDOR"
    else
        printf "${RED}ALARM  ${NC} | %-15s | ${RED}%s${NC}\n" "$IP" "$VENDOR"
        # Send Notification
        termux-notification -t "⚠️ INTRUDER ALERT" -c "$VENDOR ($IP) is on your Wi-Fi!" --priority high --vibrate 500
    fi
done

echo -e "--------------------------------------------------"
echo -e "${YELLOW}Scan complete.${NC}"

