#!/bin/bash

# --- CONFIG & PATHS ---
DIR="$HOME/.sentinel"
mkdir -p "$DIR"
WHITELIST="$DIR/whitelist.txt"
CACHE="$DIR/vendor_cache.txt"
LOG="$DIR/intruder_history.log"
TOUCH_FILE="$DIR/last_scan.txt"

# --- STYLING ---
G='\033[0;32m' # GREEN
R='\033[0;31m' # RED
Y='\033[1;33m' # YELLOW
C='\033[0;36m' # CYAN
NC='\033[0m'    # NO COLOR

touch "$WHITELIST" "$CACHE" "$LOG"

clear
echo -e "${C}==================================================${NC}"
echo -e "${Y}          SENTINEL ULTIMATE NETWORK SUITE         ${NC}"
echo -e "${C}==================================================${NC}"

# 1. GET IP (Prompt or Auto)
AUTO_IP=$(termux-wifi-connectioninfo | grep -oP '(?<="ip": ")[^"]*')
echo -e "${Y}[?] Detected IP: ${C}$AUTO_IP${NC}"
read -p "Press ENTER to use this IP, or type a custom IP: " USER_IP
SCAN_IP=${USER_IP:-$AUTO_IP}

if [ -z "$SCAN_IP" ]; then echo -e "${R}Error: No IP found.${NC}"; exit 1; fi

RANGE=$(echo $SCAN_IP | cut -d '.' -f 1-3)".0/24"
echo -e "${G}[*] Target Range: $RANGE${NC}"
echo -e "--------------------------------------------------"

# 2. THE SCAN ENGINE
echo -e "STATUS  | IP ADDRESS      | VENDOR / HARDWARE"
echo -e "--------------------------------------------------"

# Use nmap -sn (Ping scan) which is effective for non-root ARP discovery
nmap -sn $RANGE -oG - | grep "Host:" | while read -r line; do
    IP=$(echo $line | awk '{print $2}')
    # Extract MAC Address
    MAC=$(echo $line | grep -oE '([[:xdigit:]]{2}:){5}[[:xdigit:]]{2}')
    
    if [ -z "$MAC" ]; then
        MAC="INTERNAL"
        VENDOR="Local Device/Router"
    else
        # Vendor Lookup with Cache
        VENDOR=$(grep -i "$MAC" "$CACHE" | cut -d'|' -f2)
        if [ -z "$VENDOR" ]; then
            VENDOR=$(curl -s "https://api.macvendors.com/$MAC")
            if [[ "$VENDOR" == *"errors"* ]] || [ -z "$VENDOR" ]; then VENDOR="Unknown"; fi
            echo "$MAC|$VENDOR" >> "$CACHE"
            sleep 0.5 # API Friendly
        fi
    fi

    # 3. WHITELIST & LOGGING LOGIC
    if grep -qi "$MAC" "$WHITELIST" || [ "$MAC" == "INTERNAL" ]; then
        printf "${G}TRUSTED${NC} | %-15s | %s\n" "$IP" "$VENDOR"
    else
        printf "${R}INTRUDER${NC}| %-15s | %s\n" "$IP" "$VENDOR"
        # Log to file
        echo "[$(date "+%Y-%m-%d %H:%M:%S")] ALERT: $IP ($MAC) - $VENDOR" >> "$LOG"
        # Android Notification
        termux-notification -t "SENTINEL: INTRUDER" -c "$IP ($VENDOR) detected!" --priority high --vibrate 500
    fi
done

date > "$TOUCH_FILE"
echo -e "--------------------------------------------------"
echo -e "${Y}Scan Complete. Logs: $LOG${NC}"
