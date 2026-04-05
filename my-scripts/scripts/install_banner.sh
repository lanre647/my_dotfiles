#!/bin/zsh

# 1. Install Dependencies
echo "Installing dependencies..."
pkg install termux-api jq figlet lolcat curl -y

# 2. Create the Banner Script
cat << 'INNER_EOF' > ~/rbanner.sh
#!/zsh

# --- CONFIG ---
TEXT="LANRE"
FONT="slant"
TODO_FILE="$HOME/.todo"
WEATHER_CACHE="/tmp/weather_cache"

# --- NORD COLORS ---
NORD_BLUE="\e[38;5;111m"
NORD_GREY="\e[38;5;103m"
NORD_DIM="\e[38;5;244m"
RESET="\e[0m"

term_width=$(tput cols)

# 1. Centered ASCII Name
FONT_FILE=$(find /data/data/com.termux/files/usr/share/figlet -name "${FONT}.flf" | head -n 1)
[[ -z "$FONT_FILE" ]] && FONT_FILE="standard"

ascii=$(figlet -f "$FONT_FILE" "$TEXT")
max_line_len=0
while IFS= read -r line; do
    [[ ${#line} -gt $max_line_len ]] && max_line_len=${#line}
done <<< "$ascii"

padding=$(( (term_width - max_line_len) / 2 ))
[[ $padding -lt 0 ]] && padding=0
pad_str=$(printf '%*s' "$padding" "")

clear
while IFS= read -r line; do
    echo -e "${pad_str}${line}"
done <<< "$ascii" | lolcat -p 100 -F 0.1

# 2. Separator
printf "$NORD_DIM%*s$RESET\n" "$term_width" "" | sed "s/ /─/g"

# 3. Background Weather Fetch (Cached for 15 mins)
if [[ ! -f "$WEATHER_CACHE" || $(find "$WEATHER_CACHE" -mmin +15) ]]; then
    (curl -s "wttr.in?format=%c%t" > "$WEATHER_CACHE" &)
fi
weather=$(cat "$WEATHER_CACHE" 2>/dev/null || echo "☁️ Loading")

# 4. Stats
bat=$(termux-battery-status 2>/dev/null | jq -r '.percentage' 2>/dev/null || echo "??")
ip=$(termux-wifi-connection 2>/dev/null | jq -r '.ip' 2>/dev/null)
[[ "$ip" == "null" || -z "$ip" ]] && ip="Offline"

# 5. Status Line
hour=$(date +%H)
icons=("❄️" "🌊" "🧊" "🏔️" "🌌")
random_icon=${icons[$RANDOM % ${#icons[@]}]}
greet="Evening"
[[ $hour -lt 12 ]] && greet="Morning"
[[ $hour -ge 12 && $hour -lt 18 ]] && greet="Afternoon"

status_text="$random_icon $greet | 🌐 $ip | 🔋 $bat% | $weather"
status_pad=$(( (term_width - ${#status_text}) / 2 ))
[[ $status_pad -lt 0 ]] && status_pad=0
printf "%*s${NORD_BLUE}%s${RESET}\n" "$status_pad" "" "$status_text"

# 6. To-Do List
if [[ -f "$TODO_FILE" && -s "$TODO_FILE" ]]; then
    echo ""
    header="── Tasks ──"
    printf "%*s${NORD_GREY}%s${RESET}\n" $(( (term_width - ${#header}) / 2 )) "" "$header"
    while IFS= read -r task; do
        task_pad=$(( (term_width - ${#task} - 4) / 2 ))
        [[ $task_pad -lt 0 ]] && task_pad=0
        printf "%*s  ${NORD_DIM}•${RESET} %s\n" "$task_pad" "" "$task"
    done < "$TODO_FILE"
fi
echo ""
INNER_EOF

chmod +x ~/rbanner.sh

# 3. Update .zshrc with the Zsh "Hook" and Todo Alias
cat << 'ZSH_EOF' >> ~/.zshrc

# --- BANNER CONFIG ---
source ~/rbanner.sh

# Refresh banner every 5 minutes (300s) on command prompt
LAST_REFRESH=$(date +%s)
precmd() {
    local now=$(date +%s)
    if (( now - LAST_REFRESH > 300 )); then
        source ~/rbanner.sh
        LAST_REFRESH=$now
    fi
}

# To-do Management
todo() {
    if [[ -z "$1" ]]; then
        cat -n ~/.todo 2>/dev/null || echo "No tasks."
    elif [[ "$1" == "clear" ]]; then
        > ~/.todo && echo "Cleared." && source ~/rbanner.sh
    else
        echo "$*" >> ~/.todo && source ~/rbanner.sh
    fi
}
ZSH_EOF

echo "Installation complete! Restarting Zsh..."
exec zsh
