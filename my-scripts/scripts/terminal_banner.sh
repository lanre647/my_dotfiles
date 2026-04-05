#!/usr/bin/env bash

# --- 1. Preparation ---
clear
USER_NAME=$(whoami)
DATE_STR=$(date +'%a, %d %b %H:%M')
HOUR=$(date +%H)
TODO_FILE="$HOME/notes/todo.md"

# --- 2. Data Gathering (Optimized) ---

# Greeting
if [ "$HOUR" -lt 12 ]; then GREET="Good Morning"; elif [ "$HOUR" -lt 18 ]; then GREET="Good Afternoon"; else GREET="Good Evening"; fi

# Active Services Check
SERVICES=""
pgrep -x "transmission-daemon" > /dev/null && SERVICES+="Torrent "
pgrep -x "tor" > /dev/null && SERVICES+="Tor "
pgrep -x "sshd" > /dev/null && SERVICES+="SSH "
SERVICES=${SERVICES:-None}

# Network Data (Fast timeouts to prevent lag)
EXT_IP=$(curl -s --connect-timeout 1.0 ifconfig.me || echo "Offline")
WEATHER=$(curl -s --connect-timeout 1.0 "wttr.in?format=%c" || echo "☁️")

# IP Logic
INT_IP=$(getprop dhcp.wlan0.ipaddress)
NET_LABEL="WiFi"
if [ -z "$INT_IP" ]; then
    INT_IP=$(ip addr show rmnet_data0 2>/dev/null | grep 'inet ' | awk '{print $2}' | cut -d/ -f1)
    [ -z "$INT_IP" ] && INT_IP=$(getprop dhcp.rmnet0.ipaddress)
    NET_LABEL="Cell"
fi
INT_IP=${INT_IP:-Protected}

# System Stats
LOAD_AVG=$(uptime | awk -F'load average:' '{ print $2 }' | cut -d, -f1 | tr -d ' ')
BATTERY=$(termux-battery-status 2>/dev/null | grep percentage | awk -F: '{print $2}' | tr -d ' ,')
[ -z "$BATTERY" ] && BATTERY=$(cat /sys/class/power_supply/battery/capacity 2>/dev/null || echo "N/A")

# Storage & Updates (This is usually the slowest part)
STORAGE=$(df -h ~ | awk 'NR==2 {print $4}')
UPDATES_COUNT=$(apt list --upgradable 2>/dev/null | grep -c upgradable)

# --- 3. Display ---

# Header
toilet -f standard -F metal "TERMINAL"
echo -e "\e[1m$GREET, $USER_NAME! $WEATHER\e[0m"
echo -e "\e[1;34m--------------------------------------\e[0m"

# Formatting columns with printf
printf "\e[1;32m%-12s\e[0m %-18s \e[2m(%s)\e[0m\n" "Internal:" "$INT_IP" "$NET_LABEL"
printf "\e[1;32m%-12s\e[0m %-18s\n"             "External:" "$EXT_IP"

# Battery Color Logic
if [[ "$BATTERY" != "N/A" ]]; then
    [ "$BATTERY" -le 20 ] && BC="\e[1;31m" || { [ "$BATTERY" -le 50 ] && BC="\e[1;33m" || BC="\e[1;32m"; }
    printf "\e[1;32m%-12s\e[0m ${BC}%s%%\e[0m\n" "Battery:" "$BATTERY"
fi

printf "\e[1;32m%-12s\e[0m %-18s\n" "Storage:" "$STORAGE free"

# Load Color Logic
[[ ${LOAD_AVG%.*} -ge 5 ]] && LC="\e[1;31m" || LC="\e[0m"
printf "\e[1;32m%-12s\e[0m ${LC}%-18s\e[0m\n" "Load Avg:" "$LOAD_AVG"

printf "\e[1;32m%-12s\e[0m %-18s\n" "Services:" "$SERVICES"

# Updates Logic
if [ "$UPDATES_COUNT" -gt 0 ]; then
    printf "\e[1;32m%-12s\e[0m \e[1;33m%s packages wait\e[0m\n" "Updates:" "$UPDATES_COUNT"
else
    printf "\e[1;32m%-12s\e[0m %-18s\n" "Updates:" "Fully Updated"
fi

printf "\e[1;32m%-12s\e[0m %-18s\n" "Date:" "$DATE_STR"
echo -e "\e[1;34m--------------------------------------\e[0m"

# --- 4. Task Spotlight & Tips ---

# Spotlight from todo.md
if [ -f "$TODO_FILE" ]; then
    RANDOM_TASK=$(grep -v '^#' "$TODO_FILE" | grep '[a-zA-Z]' | shuf -n 1)
    if [ -n "$RANDOM_TASK" ]; then
        echo -e "\e[1;35m🎯 Spotlight:\e[0m \e[3m$RANDOM_TASK\e[0m"
    fi
fi

TIPS=(
  "Use 'du -sh *' to see folder sizes."
  "Run 'pkg clean' to save space."
  "Aliases save lives: 'alias update=\"pkg upgrade\"'."
  "Private IPs for the LAN, Public IPs for the WAN."
  "Load over 8.0? Use 'htop' to find the killer."
)
echo -e "\e[2mTip: ${TIPS[$RANDOM % ${#TIPS[@]}]}\e[0m"
[ -f "$TODO_FILE" ] && echo -e "\e[1;35mCheck tasks: 'glow $TODO_FILE'\e[0m"
echo ""
