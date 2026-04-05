#!/bin/zsh

# --- CONFIG & FONTS ---
TEXT="TERMUX"
COOL_FONTS=(terminus ticksslant slant ublk starwars standard block thin mini graffiti 3D-ASCII script epic isometric1 maxiwi larry3d alligator Ghost Bloody bulbhead ivrit THIS Sweet isometric1 isometric3 koholint varsity)
SELECTED_FONT=${COOL_FONTS[$RANDOM % ${#COOL_FONTS[@]} + 1]}

# --- SOUND CONFIG ---
# Path to your startup sound. Change this to your actual file path!
STARTUP_SOUND="$HOME/catfish.mp3"

TODO_FILE="$HOME/.todo"
WEATHER_CACHE="$HOME/.weather_cache"
SPEED_CACHE="$HOME/.speed_cache"
UPDATE_CACHE="$HOME/.update_cache"

# --- EDUCATIONAL FACTS ---
FACTS=(
    "Linux has two birthdays: August 25, 1991 (announcement) and October 5, 1991 (first release)."
    "The first Linux kernel was only about 10,000 lines of code."
    "Android, the world’s most popular mobile OS, is based on the Linux kernel."
    "NASA has used Linux systems in space missions, including the International Space Station."
    "Linux powers most of the world’s stock exchanges, including NYSE and NASDAQ."
    "The mascot Tux the penguin was created by Larry Ewing in 1996."
    "Linux distributions are often called 'distros'—there are hundreds, from Ubuntu to Arch."
    "Linux is licensed under the GNU General Public License (GPL)."
    "The majority of web servers worldwide run on Linux."
    "Linux is the foundation of container technologies like Docker and Kubernetes."
    "The first Linux version (0.01) could only run on Intel 386 processors."
    "Linux is used in smart devices, from TVs to refrigerators."
    "Chromebooks run ChromeOS, which is built on Linux."
    "Linux is the backbone of most cybersecurity tools and penetration testing distros."
    "Linux has no official 'owner'; it’s maintained by a global community."
    "The Linux kernel receives thousands of commits each year from developers worldwide."
    "Linux is behind Tesla’s in‑car operating system."
    "The PlayStation 3 could run Linux until Sony removed the feature."
    "Linux dominates the server market with over 70% share."
    "Linux is used in submarines and military drones."
    "Linux Mint was first released in 2006 as a user‑friendly Ubuntu derivative."
    "Linux can run on devices as small as a wristwatch."
    "IBM invested $1 billion in Linux development in 2000."
    "Linux is at the core of the CERN Large Hadron Collider systems."
    "Linux kernel developers come from companies like Intel, Red Hat, Google, and Microsoft."
    "Linux is the OS behind most smart routers and firewalls."
    "SteamOS, used for gaming, is based on Linux."
    "Linux has powered the fastest supercomputer in the world for years."
    "Linux is used in Hollywood for rendering CGI effects."
    "Linux is the foundation of blockchain nodes and cryptocurrency mining rigs."
    "Linux has been ported to more hardware architectures than any other OS."
    "Linux is used in self‑driving cars for real‑time processing."
    "Linux is the default OS for Raspberry Pi boards."
    "Linux is used in ATMs and banking systems worldwide."
    "Linux kernel releases happen roughly every 9–10 weeks."
    "Linux is the OS behind most smart home hubs."
    "Linux is used in drones for flight control software."
    "Linux is the OS behind Amazon Kindle devices."
    "Linux is used in medical imaging devices."
    "Linux is the OS behind most DNS root servers."
    "Linux is used in satellites orbiting Earth."
    "Linux is the OS behind Google’s search infrastructure."
    "Linux is used in the majority of web hosting services."
    "Linux is the OS behind Facebook’s massive data centers."
    "Linux is used in smart thermostats like Nest."
    "Linux is the OS behind Uber’s ride‑sharing infrastructure."
    "Linux is used in the majority of AI research clusters."
    "Linux is the OS behind Netflix’s streaming servers."
    "Linux is used in the majority of IoT devices worldwide."
    "In Bash, '!!' repeats the last command — handy for sudo retries."
    "In Vim, typing ':set number' shows line numbers instantly."
    "In Git, 'git reflog' can recover commits you thought were lost."
    "In Python, list comprehensions are often faster than for‑loops."
    "In C, 'printf(\"%.*s\", n, str)' prints only the first n chars of a string."
    "In JavaScript, '===' checks both value and type, unlike '=='."
    "In Linux, 'Ctrl+R' in the terminal lets you search command history."
    "In Bash, '!!:s/foo/bar/' replaces 'foo' with 'bar' in the last command."
    "In Linux, '/dev/null' is the famous black hole for unwanted output."
    "In Linux, 'fork bombs' are tiny scripts that crash systems by infinite processes."
    "In Linux, 'alias' can save you from typing long commands repeatedly."
    "In Linux, 'htop' is a colorful alternative to 'top'."
    "In Linux, 'ncdu' shows disk usage in a neat interactive way."
    "In Linux, 'fortune | cowsay' gives you a talking ASCII cow."
    "In Linux, 'sl' installs a joke program that shows a steam locomotive when you mistype 'ls'."
    "In Linux, 'yes' prints 'y' forever until stopped — useful for stress testing."
    "In Linux, 'rev' reverses text strings line by line."
    "In Linux, 'tac' prints files backwards, line by line."
    "In Linux, 'cmatrix' gives you a Matrix‑style terminal animation."
    "In Linux, 'toilet' prints big ASCII art text banners."
    "In Linux, 'figlet' also makes ASCII art text."
    "In Linux, 'lolcat' adds rainbow colors to terminal output."
    "The original 'vi' editor was written in 1976 — it predates the PC."
    "The 'make' utility was created in 1976 to automate builds — still used today."
    "The first computer virus for Linux was called 'Staog' in 1996."
    "The 'espeak' command can make your Linux box talk out loud."
    "The 'telnet towel.blinkenlights.nl' command plays Star Wars in ASCII art."
)RANDOM_FACT=${FACTS[$RANDOM % ${#FACTS[@]} + 1]}

# --- NORD COLORS ---
NORD_PALETTE=("\e[38;5;111m" "\e[38;5;109m" "\e[38;5;110m" "\e[38;5;150m" "\e[38;5;143m")
NORD_ACCENT=${NORD_PALETTE[$RANDOM % ${#NORD_PALETTE[@]} + 1]}
NORD_GREY="\e[38;5;103m"
NORD_DIM="\e[38;5;244m"
NORD_RED="\e[38;5;196m"
NORD_CYAN="\e[38;5;109m"
RESET="\e[0m"

term_width=$(tput cols)

# 0. Startup Sound (Non-blocking)
if [[ -f "$STARTUP_SOUND" ]]; then
    (play-audio "$STARTUP_SOUND" &>/dev/null &)
fi

# 1. Centered ASCII Name
FONT_PATH=$(find /usr/share/figlet /usr/share/figlet/fonts $PREFIX/share/figlet -name "${SELECTED_FONT}.flf" 2>/dev/null | head -n 1)

clear
echo -e "${NORD_DIM}Font: $SELECTED_FONT${RESET}"

if [[ -n "$FONT_PATH" ]]; then
    fig_cmd=(figlet -d "$(dirname "$FONT_PATH")" -f "$SELECTED_FONT" "$TEXT")
else
    fig_cmd=(figlet -f standard "$TEXT")
fi

"${fig_cmd[@]}" | expand | while IFS= read -r line; do
    clean_line=$(echo "$line" | sed 's/[[:space:]]*$//')
    line_len=$(echo -n "$clean_line" | wc -m)
    padding=$(( (term_width - line_len) / 2 ))
    [[ $padding -lt 0 ]] && padding=0
    printf "%*s%s\n" "$padding" "" "$clean_line"
done | lolcat -p 100 -F 0.1

# 2. Separator
printf "$NORD_DIM%*s$RESET\n" "$term_width" "" | sed "s/ /─/g"

# 3. System Health Stats
storage_percent=$(df /data | tail -1 | awk '{print $5}' | sed 's/%//')
[[ $storage_percent -ge 90 ]] && storage_display="${NORD_RED}󰋊 ${storage_percent}%!${NORD_ACCENT}" || storage_display="󰋊 ${storage_percent}%"

bat_info=$(termux-battery-status 2>/dev/null)
bat_val=$(echo "$bat_info" | jq -r '.percentage' 2>/dev/null || echo "100")
bat_temp=$(echo "$bat_info" | jq -r '.temperature' 2>/dev/null || echo "0")

if [[ $bat_val -lt 20 ]]; then
    bat_display="${NORD_RED}󰁺 ${bat_val}%${NORD_ACCENT}"
elif [[ $(echo "$bat_temp > 45" | bc 2>/dev/null) -eq 1 ]]; then
    bat_display="${NORD_RED}󰂈 ${bat_val}% (${bat_temp}°C)${NORD_ACCENT}"
else
    bat_display="󰁹 ${bat_val}% (${bat_temp}°C)"
fi

# 4. Background Checks (Speed & Updates)
if [[ ! -f "$SPEED_CACHE" || $(find "$SPEED_CACHE" -mmin +1440) ]]; then
    (speedtest-cli --simple 2>/dev/null | xargs echo > "$SPEED_CACHE" &)
fi
net_speed=$(cat "$SPEED_CACHE" 2>/dev/null | head -n 1)
[[ -z "$net_speed" ]] && net_speed="󰓅 Testing..." || net_speed="󰓅 $net_speed"

if [[ ! -f "$UPDATE_CACHE" || $(find "$UPDATE_CACHE" -mmin +360) ]]; then
    (apt list --upgradable 2>/dev/null | grep -c upgradable > "$UPDATE_CACHE" &)
fi
up_count=$(cat "$UPDATE_CACHE" 2>/dev/null || echo "0")
[[ "$up_count" -gt 0 ]] && up_display="${NORD_RED}󰚰 $up_count Updates${NORD_ACCENT}" || up_display="󰚰 Up to date"

# 5. IP & Weather
ip=$(termux-wifi-connection 2>/dev/null | jq -r '.ip' 2>/dev/null)
[[ "$ip" == "null" || -z "$ip" ]] && ip_display="${NORD_RED}󰅛 Offline${NORD_ACCENT}" || ip_display="󰖟 $ip"

if [[ ! -f "$WEATHER_CACHE" || $(find "$WEATHER_CACHE" -mmin +15) ]]; then
    (curl -s "wttr.in?format=%c%t" > "$WEATHER_CACHE" &)
fi
weather=$(cat "$WEATHER_CACHE" 2>/dev/null || echo "󰖐 --°")

# 6. Build Status Line
hour=$(date +%H)
if (( hour < 12 )); then greet="Morning 󰖭"; elif (( hour < 18 )); then greet="Afternoon 󰭎"; else greet="Evening 󰖔"; fi

status_text="$greet | $ip_display | $bat_display | $storage_display | $up_display | $net_speed | $weather"
raw_text=$(echo -e "$status_text" | sed 's/\x1b\[[0-9;]*m//g')
status_pad=$(( (term_width - ${#raw_text}) / 2 ))
printf "%*s${NORD_ACCENT}%b${RESET}\n" "$((status_pad > 0 ? status_pad : 0))" "" "$status_text"

# 7. Educational Fact & Security Info
echo ""
fact_header="󰋗 Did you know?"
printf "%*s${NORD_ACCENT}%s${RESET}\n" $(( (term_width - ${#fact_header}) / 2 )) "" "$fact_header"
echo "$RANDOM_FACT" | fold -s -w $((term_width - 10)) | while read -r line; do
    line_clean=$(echo "$line" | sed 's/[[:space:]]*$//')
    printf "%*s${NORD_DIM}%s${RESET}\n" $(( (term_width - ${#line_clean}) / 2 )) "" "$line_clean"
done

sec_text="󰒃 System boot: $(uptime -s 2>/dev/null)"
printf "\n%*s${NORD_DIM}%s${RESET}\n" $(( (term_width - ${#sec_text}) / 2 )) "" "$sec_text"

# 8. To-Do List
if [[ -f "$TODO_FILE" && -s "$TODO_FILE" ]]; then
    echo ""
    header="󱘲 Pending Tasks"
    printf "%*s${NORD_GREY}%s${RESET}\n" $(( (term_width - ${#header}) / 2 )) "" "$header"
    while IFS= read -r task; do
        task_clean=$(echo "$task" | sed 's/[[:space:]]*$//')
        task_pad=$(( (term_width - ${#task_clean} - 4) / 2 ))
        printf "%*s  ${NORD_CYAN}󰄱${RESET} %s\n" "$((task_pad > 0 ? task_pad : 0))" "" "$task_clean"
    done < "$TODO_FILE"
fi
echo ""

