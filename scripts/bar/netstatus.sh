#!/bin/sh
eth=$(ip link show | awk -F: '/state UP/ && $2 !~ /lo|wlan/ {print $2}')
wifi_info=$(iw dev wlan0 link 2>/dev/null)

ping_out=$(ping -c 1 -W 1 1.1.1.1 2>/dev/null)
online=$?
lat=$(echo "$ping_out" | grep "time=" | sed -E "s/.*time=([0-9.]+).*/\1/" | cut -d. -f1)

vpn=$(ip link show | grep -E "tun0|wg0")

if [ -n "$eth" ]; then
    if [ $online -eq 0 ]; then
        [ -n "$vpn" ] && echo " 🔒 ${lat}ms" || echo " ${lat}ms"
    else
        echo "⚠ Wired (No Net)"
    fi
else
    if echo "$wifi_info" | grep -q "Connected"; then
        ssid=$(echo "$wifi_info" | grep SSID | cut -d" " -f2- | sed "s/\x20/ /g")
        if [ $online -eq 0 ]; then
            [ -n "$vpn" ] && echo " $ssid 🔒 ${lat}ms" || echo " $ssid ${lat}ms"
        else
            echo "⚠ $ssid (No Net)"
        fi
    else
        echo " Disconnected"
    fi
fi

