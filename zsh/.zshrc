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




# Start/Stop Tor quickly
alias tor-on="pkg install tor -y && tor &"
alias tor-off="pkill tor"

# Force any CLI tool through Tor/ProxyChains
alias pxc="proxychains4 -q"

# Check your external IP vs Tor IP
alias myip="curl -s https://ifconfig.me"
alias torip="pxc curl -s https://ifconfig.me"

# The Nuke Alias
alias nuke="rm -f ~/.zsh_history && history -c && pkill -u $(whoami) && exit"

# The "Quiet Nuke" (Wipes logs but keeps the session open)
alias wipe="rm -f ~/.zsh_history && truncate -s 0 ~/.zsh_history && history -p && clear"

alias grab="~/grab.sh"
alias kali="nh"
alias nv='nvim' 
alias ytdlmp4='yt-dlp -f "bv[ext!=webm][height<=720]+ba/b[ext!=webm][height<=720]" --merge-output-format mp4 -o "%(title)s.%(ext)s"'

# Download as High Quality MP3 (Audio)
alias getmp3='yt-dlp -x --audio-format mp3 --audio-quality 0 --add-metadata --embed-thumbnail -o "~/storage/downloads/%(title)s.%(ext)s"'

# Download as Best Quality Video (MP4)
alias getvid='yt-dlp -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best" --add-metadata -o "~/storage/downloads/%(title)s.%(ext)s"'
alias rm="rm -i"

alias ksh='rish -c "nh"'


eval "$(zoxide init zsh)"
source <(fzf --zsh)
alias lg='lazygit'

alias clean='clear && cowsay -r "welcome back, master" | lolcat'
alias figlett='figlet -d ~/.local/share/figlet'
alias mst='echo "--- Home Directory Usage ---" && du -h -d 1 "$HOME" | sort -hr | head -n 5 && echo "--- Total Termux App Usage ---" && du -sh "$PREFIX/.."'
alias ops='bash ~/scripts/dashboard.sh'
alias sweep='rm -rf ~/.cache/* $PREFIX/tmp/* && npm cache clean --force && go clean -cache && apt autoremove -y && apt clean'
clear
# cowsay -r "welcome back, master" | lolcat
alias ls='eza --all --long --group --group-directories-first --icons --header --time-style long-iso'   
eval "$(starship init zsh)"
# bash ~/scripts/daily_brief.sh
# bash ~/scripts/terminal_banner.sh
export TZ="Africa/Lagos"
# echo "W E L C O M E  B A C K,  L A N R E" | boxes -a vcjchc -d dragon 

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


# Toggle Banner Visibility
# Usage: 'bt' to hide/show
bt() {
    if [[ "$SHOW_BANNER" == "false" ]]; then
        export SHOW_BANNER="true"
        source ~/rbanner.sh
        echo "Banner: ENABLED"
    else
        export SHOW_BANNER="false"
        clear
        echo "Banner: DISABLED"
    fi
}

# Modify your existing precmd hook to respect this toggle:
precmd() {
    if [[ "$SHOW_BANNER" != "false" ]]; then
        local now=$(date +%s)
        if (( now - LAST_REFRESH > 300 )); then
            source ~/rbanner.sh
            LAST_REFRESH=$now
        fi
    fi
}

