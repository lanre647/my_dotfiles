#!/bin/bash

# 1. Configuration
NAME="Master Lanre"
CITY="Lagos" 

# 2. Get Weather & Battery
WEATHER=$(curl -s "wttr.in/${CITY}?format=%t+and+%C")
BATT=$(termux-battery-status | jq .percentage)

# 3. The Visual Output
echo -e "\e[1;34m======================================\e[0m"
echo -e "\e[1;32mWelcome back, $NAME!\e[0m"
echo -e "\e[1;33mWeather:\e[0m $WEATHER in $CITY"
echo -e "\e[1;33mBattery:\e[0m $BATT%"
echo -e "\e[1;34m--------------------------------------\e[0m"
echo -e "\e[1;35mYOUR TO-DO LIST:\e[0m"

# 4. Display the Tasks (Modify this list name if you change it later)
# This uses a simple echo for now, but stays as a reminder of what we added:
echo -e " \e[1;37m- Pray\e[0m"
echo -e " \e[1;37m- code\e[0m"
echo -e " \e[1;37m- gym\e[0m"
echo -e "\e[1;34m======================================\e[0m"

# 5. Text-to-Speech
termux-tts-speak "Welcome back master. You have tasks waiting and other tasks might be found in note and screenshots"

