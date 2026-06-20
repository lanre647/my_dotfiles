# ============================================================
#  .zshrc — Organized Configuration
# ============================================================


# ------------------------------------------------------------
# POWERLEVEL10K INSTANT PROMPT (must stay near top)
# ------------------------------------------------------------
#if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
 # source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi


# ------------------------------------------------------------
# OH MY ZSH SETUP
# ------------------------------------------------------------
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME=""

# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )
# CASE_SENSITIVE="true"
# HYPHEN_INSENSITIVE="true"
# zstyle ':omz:update' mode disabled
# zstyle ':omz:update' mode auto
# zstyle ':omz:update' mode reminder
# zstyle ':omz:update' frequency 13
# DISABLE_MAGIC_FUNCTIONS="true"
# DISABLE_LS_COLORS="true"
# DISABLE_AUTO_TITLE="true"
# ENABLE_CORRECTION="true"
# COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
# HIST_STAMPS="mm/dd/yyyy"
# ZSH_CUSTOM=/path/to/new-custom-folder

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh


# ------------------------------------------------------------
# ENVIRONMENT & PATH
# ------------------------------------------------------------
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"
# export LANG=en_US.UTF-8
# export ARCHFLAGS="-arch $(uname -m)"
export TERMINAL="kitty"
# export TERM="xterm-256color"

# fnm (Fast Node Manager)
FNM_PATH="/home/lanre/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "$(fnm env --shell zsh)"
fi


# ------------------------------------------------------------
# EDITOR
# ------------------------------------------------------------
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
  export EDITOR='nvim'
# fi


# ------------------------------------------------------------
# TOOL INITIALISATION
# ------------------------------------------------------------
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
source <(fzf --zsh)
# eval "$(ssh-agent -s)"
# ssh-add ~/.ssh/id_ed25519


# ------------------------------------------------------------
# CORE ALIASES — Navigation & Utilities
# ------------------------------------------------------------
alias c='clear'
alias v='nvim'
alias open="termux-open"
alias ls='eza --icons -F -H --group-directories-first --git -1'
# alias ls='eza --all --long --group --group-directories-first --icons --header --time-style long-iso'

alias ..='cd ..'
alias ...='cd ../..'
alias mkd='mkdir -p'
alias path='echo $PATH | tr ":" "\n"'


# ------------------------------------------------------------
# CORE ALIASES — System & Maintenance
# ------------------------------------------------------------
alias mst='echo "--- Home Directory Usage ---" && du -h -d 1 "$HOME" | sort -hr | head -n 5 && echo "--- Total Termux App Usage ---" && du -sh "$PREFIX/.."'
alias ops='bash ~/scripts/dashboard.sh'
alias lg='lazygit'
alias ports='ss -tulnp'
alias psg='ps aux | grep'

# Host-aware sweep
function sweep() {
    if [[ "$(uname -o)" == "Android" ]]; then
        # Termux
        rm -rf ~/.cache/*
        rm -rf $PREFIX/tmp/*
        npm cache clean --force
        go clean -cache
        apt autoremove -y && apt clean
    else
        # EndeavourOS / Arch
        rm -rf ~/.cache/*
        npm cache clean --force
        go clean -cache
        sudo pacman -Sc --noconfirm
        yay -Sc --noconfirm
    fi
    echo "✅ Sweep done."
}

# Host-aware update
function update() {
    if [[ "$(uname -o)" == "Android" ]]; then
        apt update && apt upgrade -y
    else
        sudo pacman -Syu && yay -Syu
    fi
}


# ------------------------------------------------------------
# CORE ALIASES — DWM & Dotfiles
# ------------------------------------------------------------
alias recomp='cd ~/suckless-meta/dwm && rm -rf config.h && sudo make clean install'
alias dwmconf='nvim ~/suckless-meta/dwm/config.def.h'
alias niriconf='nvim ~/.config/niri/config.kdl'
alias xconf='nvim ~/dotfiles/scripts/start_dwm.sh'
alias nvimconf= 'z nvim && nvim .'

# ------------------------------------------------------------
# CORE ALIASES — Neovim
# ------------------------------------------------------------
alias vi='nvim .'
alias vrc='nvim ~/.zshrc'
alias vdots='cd ~/dotfiles && nvim .'

# ------------------------------------------------------------
# CORE ALIASES — Git
# ------------------------------------------------------------
alias gst='git status'
alias glo='git log --oneline --graph --decorate -10'
alias check-secrets="grep -rE 'API_KEY|SECRET|PASSWORD' ."

function gpush() {
    git add .
    git diff --cached --stat
    echo -n "Commit message (leave blank to auto): "
    read msg
    if [[ -z "$msg" ]]; then
        local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
        local changed=$(git diff --cached --name-only | wc -l | tr -d ' ')
        msg="[$branch] Update $changed file(s) — $(date +'%b %d, %Y')"
    fi
    git commit -m "$msg" && git push origin main
}


# ------------------------------------------------------------
# CORE ALIASES — Media & Downloads
# ------------------------------------------------------------
alias ytdlmp4='yt-dlp -f "bv[ext!=webm][height<=720]+ba/b[ext!=webm][height<=720]" --merge-output-format mp4 -o "%(title)s.%(ext)s"'
alias getmp3='yt-dlp -x --audio-format mp3 --audio-quality 0 --add-metadata --embed-thumbnail -o "~/storage/downloads/%(title)s.%(ext)s"'
alias getvid='yt-dlp -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best" --add-metadata -o "~/storage/downloads/%(title)s.%(ext)s"'
alias play="ffplay -nodisp -autoexit"

# ------------------------------------------------------------
# CORE ALIASES — Audio & Brightness
# ------------------------------------------------------------
alias vup='amixer set Master 5%+'
alias vdown='amixer set Master 5%-'
alias bup='brightnessctl set +10%'
alias bdown='brightnessctl set 10%-'


# ------------------------------------------------------------
# CORE ALIASES — Timers
# ------------------------------------------------------------
alias r60='termdown 60 -f slant && termux-vibrate && termux-tts-speak "Time up"'
alias r90='termdown 90 -f slant && termux-vibrate && termux-tts-speak "Time up"'


# ------------------------------------------------------------
# CORE ALIASES — Terminal Browsers & Web
# ------------------------------------------------------------
alias wiki='w3m en.wikipedia.org'
alias reddit='w3m old.reddit.com'
alias news='w3m news.ycombinator.com'
alias hn='w3m news.ycombinator.com'
alias w3m-tor='pxc w3m'

function s() {
    local query=$(echo "$*" | sed 's/ /+/g')
    w3m "https://duckduckgo.com/html/?q=$query"
}


# ------------------------------------------------------------
# CORE ALIASES — Session Management
# ------------------------------------------------------------
# The Nuke Alias
alias nuke="rm -f ~/.zsh_history && history -c && pkill -u $(whoami) && exit"
# The "Quiet Nuke" (Wipes logs but keeps the session open)
alias wipe="rm -f ~/.zsh_history && truncate -s 0 ~/.zsh_history && history -p && clear"

sleeppc() {
    killall -q picom
    sleep 20
    systemctl suspend
}


# ------------------------------------------------------------
# CORE ALIASES — Shortcuts & Misc
# ------------------------------------------------------------
alias grab="~/.shortcuts/grab.sh"
alias kali="nh"
alias ksh='rish -c "nh"'


# ------------------------------------------------------------
# NETWORK & SECURITY
# ------------------------------------------------------------

# User-Agent Strings
UA_IPHONE="Mozilla/5.0 (iPhone; CPU iPhone OS 17_4 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Mobile/15E148 Safari/604.1"
UA_WINDOWS="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36"
UA_LINUX="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36"

# Identity Aliases
alias curl-iphone="curl -A '$UA_IPHONE'"
alias curl-win="curl -A '$UA_WINDOWS'"
alias curl-linux="curl -A '$UA_LINUX'"

# Proxychains shorthand
alias pxc="proxychains4 -q"

# Tor Control
alias tor-on="pgrep -x tor > /dev/null && echo '✅ Tor already running' || (tor && echo '🚀 Starting Tor...' && sleep 5)"
alias tor-off="pkill -9 tor && echo '🛑 Tor stopped.'"
alias tor-check="pxc curl -s https://check.torproject.org/api/ip"

# IP Checking
alias myip="curl -s https://ifconfig.me"
alias torip="pxc curl -s https://ifconfig.me"

# Stealth Function
# Usage: pxc-stealth-win <command>
pxc-stealth-win() {
    proxychains4 -q curl -A "$UA_WINDOWS" "$@"
}


# ------------------------------------------------------------
# BANNER & TODO SYSTEM
# ------------------------------------------------------------

# source ~/scripts/rbanner.sh

function todo() {
    if [[ -z "$1" ]]; then
        cat -n ~/.todo 2>/dev/null || echo "No tasks."
    elif [[ "$1" == "clear" ]]; then
        > ~/.todo && echo "Cleared." && source ~/scripts/rbanner.sh
    else
        echo "$*" >> ~/.todo && source ~/scripts/rbanner.sh
    fi
}


# ------------------------------------------------------------
# STARTUP
# ------------------------------------------------------------
fastfetch

#Import colorscheme from 'wal' asynchronously
# (cat ~/.cache/wal/sequences &)
# pulseaudio --kill >/dev/null 2>&1
# pulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1

# Powerlevel10k config
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
