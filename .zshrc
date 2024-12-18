# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
 # source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

default_editor='sudo micro'
zle_highlight=('paste:none')
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Path to your oh-my-zsh installation.
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

export PATH=$PATH:/home/linuxbrew/.linuxbrew/bin/oh-my-posh

zstyle ':vcs_info:*' enable false
function precmd() {
   if [[ -z $OH_MY_POSH_LOADED ]]; then
      eval "$(oh-my-posh init zsh --config ~/.mytheme.omp.json)"
      OH_MY_POSH_LOADED=1
   fi
}

export ZSH="$HOME/.oh-my-zsh"
export MICRO_LSP='python=pyls,go=gopls,typescript=deno lsp={"importMap":"import_map.json"},rust=rust-analyzer'

DISABLE_AUTO_UPDATE="true"
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
ENABLE_CORRECTION="false"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="powerlevel10k/powerlevel10k"

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
plugins=(git zsh-autosuggestions zsh-shift-select)


# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

function gitf() {
    local url="$1"
    local github_token="$GITHUB_TOKEN" # Optional: Set your GitHub token here if needed for private repos.

    if [[ -z "$url" ]]; then
        echo "Please provide a file or repository URL."
        return 1
    fi

    # Check if the URL is for a file (contains "blob/")
    if [[ "$url" == *"blob/"* ]]; then
        # Transform the GitHub file URL to the raw content URL
        local raw_url="${url/blob/raw}"

        # Set up headers if a GitHub token is provided (for private repos)
        local headers=()
        if [[ -n "$github_token" ]]; then
            headers=(-H "Authorization: token $github_token")
        fi

        # Fetch the file using curl
        curl -sSL "${headers[@]}" "$raw_url" -o "$(basename "$raw_url")"

        if [[ $? -eq 0 ]]; then
            echo "File downloaded successfully: $(basename "$raw_url")"
        else
            echo "Failed to download the file."
            return 1
        fi
    else
        # Handle repository URL
        if [[ "$url" == *".git" ]]; then
            git clone "$url"
        else
            echo "Invalid URL. Please provide a valid file or repository URL."
            return 1
        fi
    fi
}



apt() {
  command sudo nala "$@"
}

function sudo() {
  if [ "$1" = "apt" ]; then
    shift
    command sudo nala "$@"
  elif  [ "$1" = "nano" ]; then
    shift
    command sudo micro "$@"
  else
    command sudo "$@"
  fi
}
alias sudo="sudo"

sc() {
  command sudo $(fc -ln -1)
}

function history_with_timestamps() {
  awk -F';' '{
    if ($1 ~ /^: [0-9]+:/) {
      split($1, a, ": ")
      timestamp = a[2]
      command = $2
      formatted_time = strftime("%m-%d %H:%M", timestamp)  # Exclude seconds
      printf("%s  %s\n", formatted_time, command)
    } else {
      print $0
    }
  }' ~/.zsh_history
}


alias cpb="cp -t ~/Backup/ -v"
alias history=history_with_timestamps
alias update="sudo nala update && sudo nala upgrade -y"
alias fm="mc"
alias py="python3.13"
alias python="python3.13"
alias ws="cd ~/Programs"
alias nano="micro"
alias dk=docker
alias ls=lsd
alias ll="lsd -la"
alias m="micro"
alias shutdown="wsl.exe --shutdown"
alias reload="source ~/.zshrc"
alias top=htop
alias chrome.exe="/mnt/c/Program\ Files/Google/Chrome/Application/chrome.exe"
alias open=wslview
alias ..="cd .."


export DISPLAY=:0.0

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion



alias ai="/home/shafayet/automations/ai_cli.py --service groq"

plugins=(git zsh-syntax-highlighting)

# HSTR configuration - add this to ~/.zshrc
alias h=hstr                    # hh to be alias for hstr
setopt histignorespace           # skip cmds w/ leading space from history
bindkey -s "\C-r" "\C-a hstr -- \C-j"     # bind hstr to Ctrl-r (for Vi mode check doc)
export HISTFILE=~/.zsh_history
export HSTR_CONFIG="hicolor,raw-history-view"


export EDITOR=micro
export VISUAL=micro

# if grep -q "microsoft" /proc/version > /dev/null 2>&1; then
    # if service docker status 2>&1 | grep -q "is not running"; then
        # wsl.exe --distribution "${WSL_DISTRO_NAME}" --user root \
            # --exec /usr/sbin/service docker start > /dev/null 2>&1
    # fi
# fi


# Basic auto/tab complete:
autoload -U compinit && compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
_comp_options+=(globdots)

bindkey -r '^[S'


function set-env() {
    local var_name=$1
    local var_value=$2
    local file_env="$HOME/.env.zsh"  # Correct assignment

    # Ensure the .env.zsh file exists
    if [ ! -f "$file_env" ]; then
        touch "$file_env"
        echo "Created $file_env"
    fi

    # Add or update the export statement in .env.zsh
    if grep -q "^export $var_name=" "$file_env"; then
        sed -i '' "s|^export $var_name=.*|export $var_name=\"$var_value\"|" "$file_env"
        echo "Updated: export $var_name=\"$var_value\" in .env.zsh"
    else
        echo "export $var_name=\"$var_value\"" >> "$file_env"
        echo "Added: export $var_name=\"$var_value\" to .env.zsh"
    fi

    # Reload the .env.zsh file to apply changes
    source "$file_env"
    echo "Environment variable '$var_name' is now permanently set."
}


source ~/.env.zsh
export PATH=$PATH:/home/shafayet/.local/bin
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /home/shafayet/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
