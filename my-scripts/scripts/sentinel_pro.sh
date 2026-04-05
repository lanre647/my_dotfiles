#!/bin/bash

# --- CONFIG ---
WHITELIST="$HOME/mac_whitelist.txt"
GREEN='\033[0;32m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m'

clear
echo -e "${CYAN}📡 SENTINEL PRO: Hardware-Level Scanner${NC}"
echo -e "------------------------------------------"

# Ensure whitelist exists
touch "$WHITELIST"

# 1. Refresh the ARP cache (Ping scan first so the phone "sees" everyone)
MY_IP=$(ifconfig wlan0 | grep 'inet ' | awk '{print $2}')
RANGE=$(echo $MY_IP | cut -d '.' -f 1-3)".0/24"
echo -e "${CYAN}[*] Mapping network: $RANGE...${NC}"
nmap -sn $RANGE > /dev/null

# 2. Extract IP and MAC pairs using 'ip neighbor'
# We filter for 'REACHABLE' or 'STALE' devices
echo -e "Status  |  IP Address       |  MAC Address"
echo -e "------------------------------------------"

INTRUDERS=0
ip neighbor show | grep -E "REACHABLE|STALE|DELAY" | while read -r line; do
    IP=$(echo $line | awk '{print $1}')
    MAC=$(echo $line | awk '{print $5}')
    
    # Check if MAC is in whitelist
    if grep -qi "$MAC" "$WHITELIST"; then
        printf "${GREEN}TRUSTED${NC} |  %-15s |  %s\n" "$IP" "$MAC"
    else
        printf "${RED}UNKNOWN${NC} |  %-15s |  %s\n" "$IP" "$MAC"
        termux-notification -t "ID: UNKNOWN HARDWARE" -c "MAC: $MAC ($IP)" --priority high
        ((INTRUDERS++))
    fi
done

echo -e "------------------------------------------"
if [ ! -s "$WHITELIST" ]; then
    echo -e "${RED}[!] Whitelist is empty!${NC}"
    echo -e "To trust a device, run: echo 'MAC_ADDRESS' >> ~/mac_whitelist.txt"
fi

