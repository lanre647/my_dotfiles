#!/bin/bash

# --- CONFIGURATION ---
USER_NAME=$(whoami | tr '[:lower:]' '[:upper:]')
REPO_PATH="$HOME/dev/david-git"
NOTES_PATH="$HOME/notes"
TERMUX_DATA="/data/data/com.termux/files"

# --- COLORS ---
G1='\e[38;5;82m'; B1='\e[38;5;33m'; B2='\e[38;5;39m';  
R1='\e[38;5;196m'; Y1='\e[38;5;226m'; P1='\e[38;5;165m'; 
NC='\e[0m'; BOLD='\e[1m'; DIM='\e[2m'; CY='\e[36m'

# --- SECURITY & LOGIC ---

get_security_status() {
    local vpn_found=false
    
    # Check 1: DNS/Gateway check (VPNs often use private DNS)
    if getprop net.dns1 2>/dev/null | grep -qE "^10\.|^172\.|^100\."; then
        vpn_found=true
    fi

    # Check 2: Interface name via termux-api properties
    if command -v termux-network-getprop >/dev/null; then
        if termux-network-getprop 2>/dev/null | grep -qiE "tun|ppp|vpn"; then
            vpn_found=true
        fi
    fi

    if [ "$vpn_found" = true ]; then
        echo -e "${G1}󰖂 VPN:${NC} ENCRYPTED"
    else
        echo -e "${R1}󰖂 VPN:${NC} UNSECURED"
    fi

    # Audit Last Access - Fix for Termux pathing
    if command -v last >/dev/null || [ -f "$PREFIX/bin/last" ]; then
        # If 'last' is empty, it means wtmp hasn't recorded logins yet
        local last_log=$(last -n 1 2>/dev/null | head -n 1 | awk '{print $4, $5, $6}')
        echo -e "${DIM}󰒍 Last Access: ${last_log:-Session Active}${NC}"
    else
        echo -e "${DIM}󰒍 Last Access: Audit Disabled${NC}"
    fi

    # Port Monitor (Silencing netlink errors)
    local ports=$(ss -tuln 2>/dev/null | grep -c LISTEN)
    [[ $ports -gt 0 ]] && echo -e "${Y1}󱄙 Ports:${NC} $ports Listening" || echo -e "${DIM}󱄙 Ports: 0 Active${NC}"
}

get_network_info() {
    # Local IP - checking if 0.0.0.0 is returned, we try a secondary fetch
    local ip=$(termux-wifi-connectioninfo 2>/dev/null | grep "ip" | awk -F: '{print $2}' | tr -d '", ')
    [[ "$ip" == "0.0.0.0" || -z "$ip" ]] && ip=$(ip addr show wlan0 2>/dev/null | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | head -n 1)
    
    echo -e "${B2}󰀂 Local IP:${NC} ${ip:-Disconnected}"

    # Public Identity Check
    if ping -c 1 8.8.8.8 >/dev/null 2>&1; then
        local pub_ip=$(curl -s --max-time 2 ifconfig.me)
        # Check country via ipapi
        local loc=$(curl -s --max-time 2 ipapi.co/country_name/)
        echo -e "${CY}󰀂 Public:${NC} ${pub_ip:-Error} [${G1}${loc:-Remote}${NC}]"
    fi
}

get_dev_env() {
    if [ -d "$REPO_PATH" ]; then
        local branch=$(git -C "$REPO_PATH" rev-parse --abbrev-ref HEAD 2>/dev/null || echo "N/A")
        echo -e "${P1}󱇧 Project:${NC} david-git (${B2}$branch${NC})"
    fi
}

# --- THE UI ---
clear
echo -e "${B1}┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓${NC}"
echo -e "${B1}┃${NC}  ${BOLD}${USER_NAME}@SECURITY_OPS${NC} | ${G1}DASHBOARD V5${NC}           ${B1}┃${NC}"
echo -e "${B1}┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛${NC}"

get_security_status
get_network_info
get_dev_env

# Status Line
size=$(du -sh "$TERMUX_DATA" 2>/dev/null | cut -f1)
echo -ne "${G1}󰋊 Disk: $size${NC}  |  "
if command -v termux-battery-status >/dev/null; then
    bat=$(termux-battery-status 2>/dev/null | grep percentage | awk -F: '{print $2}' | tr -d ' ,')
    echo -e "${B2}󰁹 Bat: ${bat}%${NC}"
fi

echo -e "${DIM}────────────────────────────────────────────────────${NC}"
echo -e " ${G1}[1]${NC} PROJECT  ${G1}[2]${NC} NOTES   ${G1}[3]${NC} SCRUB FS"
echo -e " ${G1}[4]${NC} GIT SYNC ${G1}[5]${NC} SHELL     ${R1}[X]${NC} PANIC"
echo -e "${DIM}────────────────────────────────────────────────────${NC}"

read -n 1 -p " > COMMAND: " choice
echo -e "\n"

case $choice in
    1) cd "$REPO_PATH" && exec bash ;;
    2) cd "$NOTES_PATH" && vim . ;;
    3) 
        echo -e "${Y1}Starting File System Scrub...${NC}"
        pkg clean && apt autoremove -y
        find "$TERMUX_DATA" -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null
        echo -e "${G1}Scrub Complete.${NC}"
        ;;
    4)
        git -C "$REPO_PATH" add .
        read -p "Commit Msg: " msg
        git -C "$REPO_PATH" commit -m "${msg:-dev-sync $(date)}"
        git -C "$REPO_PATH" push
        ;;
    5) clear; echo -e "${B1}Manual Shell Active.${NC}" ;;
    x|X) pkill -u $(whoami) -9 ;;
    *) echo -e "${R1}Command Error.${NC}" ;;
esac
