# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#
#
#
#if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
 # source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME=""

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
#  [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# The Nuke Alias
alias nuke="rm -f ~/.zsh_history && history -c && pkill -u $(whoami) && exit"
# The "Quiet Nuke" (Wipes logs but keeps the session open)
alias wipe="rm -f ~/.zsh_history && truncate -s 0 ~/.zsh_history && history -p && clear"
alias grab="~/.shortcuts/grab.sh"
alias kali="nh"
alias ytdlmp4='yt-dlp -f "bv[ext!=webm][height<=720]+ba/b[ext!=webm][height<=720]" --merge-output-format mp4 -o "%(title)s.%(ext)s"'
# Download as High Quality MP3 (Audio)
alias getmp3='yt-dlp -x --audio-format mp3 --audio-quality 0 --add-metadata --embed-thumbnail -o "~/storage/downloads/%(title)s.%(ext)s"'
# Download as Best Quality Video (MP4)
alias getvid='yt-dlp -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best" --add-metadata -o "~/storage/downloads/%(title)s.%(ext)s"'
alias rm="rm -i"
# One-command commit and push
alias gpush='git add . && git commit -m "Auto-save $(date +"%Y-%m-%d %H:%M")" && git push origin main'
# Sa qfety check: Search for secret keys before pushing
alias check-secrets="grep -rE 'API_KEY|SECRET|PASSWORD' ."
alias ksh='rish -c "nh"'
alias lg='lazygit'
alias mst='echo "--- Home Directory Usage ---" && du -h -d 1 "$HOME" | sort -hr | head -n 5 && echo "--- Total Termux App Usage ---" && du -sh "$PREFIX/.."'
alias ops='bash ~/scripts/dashboard.sh'
alias sweep='rm -rf ~/.cache/* $PREFIX/tmp/* && npm cache clean --force && go clean -cache && apt autoremove -y && apt clean'
# alias ls='eza --all --long --group --group-directories-first --icons --header --time-style long-iso'   
alias ls='eza --icons -F -H --group-directories-first --git -1' 
alias cd='z'
alias open="termux-open"
alias wiki='w3m en.wikipedia.org'
alias reddit='w3m old.reddit.com'
alias news='w3m news.ycombinator.com'
s() {
    local query=$(echo "$*" | sed 's/ /+/g')
    w3m "https://duckduckgo.com/html/?q=$query"
}
alias play="ffplay -nodisp -autoexit"
alias r60='termdown 60 -f slant && termux-vibrate && termux-tts-speak "Time up"'
alias r90='termdown 90 -f slant && termux-vibrate && termux-tts-speak "Time up"'
# -----------------------------------------------------
# NETWORK AND SECURITY  ALIAS'S  

# Check if Tor is up; if not, start it and wait 5s for the circuit to build
alias tor-on="pgrep -x tor > /dev/null && echo '✅ Tor already running' || (tor && echo '🚀 Starting Tor...' && sleep 5)"
# Clean kill
alias tor-off="pkill -9 tor && echo '🛑 Tor stopped.'"
# Check status using a Tor-specific API
alias tor-check="pxc curl -s https://check.torproject.org/api/ip"
# Monitor Tor in real-time (requires 'nyx')
alias pxc="proxychains4 -q"
# Check your external IP vs Tor IP
alias myip="curl -s https://ifconfig.me"
alias torip="pxc curl -s https://ifconfig.me"
alias update="sudo pacman -Syu && yay -Syu"

# User-Agent Strings
UA_IPHONE="Mozilla/5.0 (iPhone; CPU iPhone OS 17_4 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Mobile/15E148 Safari/604.1"
UA_WINDOWS="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36"
UA_LINUX="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36"

# Identity Aliases
alias curl-iphone="curl -A '$UA_IPHONE'"
alias curl-win="curl -A '$UA_WINDOWS'"
alias curl-linux="curl -A '$UA_LINUX'"

# The "Stealth-Global" Function
# Usage: pxc-stealth-win nmap -sT [target]
pxc-stealth-win() {
    proxychains4 -q curl -A "$UA_WINDOWS" "$@"
}
# ------------------------------------------------------
# --- BANNER CONFIG ---
# source ~/scripts/rbanner.sh

# To-do Management
todo() {
    if [[ -z "$1" ]]; then
        cat -n ~/.todo 2>/dev/null || echo "No tasks."
    elif [[ "$1" == "clear" ]]; then
        > ~/.todo && echo "Cleared." && source ~/scripts/rbanner.sh
    else
        echo "$*" >> ~/.todo && source ~/scripts/rbanner.sh
    fi
}


# Toggle Banner Visibility
# Usage: 'bt' to hide/show
bt() {
    if [[ "$SHOW_BANNER" == "false" ]]; then
        export SHOW_BANNER="true"
        echo "Banner: ENABLED"
        source ~/scripts/rbanner.sh
    else
        export SHOW_BANNER="false"
        clear
        echo "Banner: DISABLED"
    fi
}
bt()

# Refresh banner every 1hr 30 minutes (4680s) on command prompt
# Modify your existing precmd hook to respect this toggle:
precmd() {
    if [[ "$SHOW_BANNER" != "false" ]]; then
        local now=$(date +%s)
        if (( now - LAST_REFRESH > 4680 )); then
           source ~/scripts/rbanner.sh
            LAST_REFRESH=$now
        fi
    fi
}

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
source <(fzf --zsh)
#eval "$(ssh-agent -s)"
#ssh-add ~/.ssh/id_ed25519
# pulseaudio --kill >/dev/null 2>&1
# pulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1
# clear


# fnm
FNM_PATH="/home/lanre/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "$(fnm env --shell zsh)"
fi

fastfetch
# export TERMINAL="kitty"
# export TERM="xterm-256color"
