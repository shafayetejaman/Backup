
default_editor='sudo micro'
zle_highlight=('paste:none')

bindkey -r '^[S'

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey '\e[3;5~' kill-word
bindkey '^H' backward-kill-word
bindkey '^[^?' kill-whole-line
bindkey '^u' clear-screen
export TERM="xterm-256color"
clear-all-input() {
    zle clear-screen
    BUFFER=""
}
zle -N clear-all-input
bindkey '^U' clear-all-input


eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

export PATH=$PATH:/home/linuxbrew/.linuxbrew/bin/oh-my-posh

zstyle ':vcs_info:*' enable false
function precmd() {
   if [[ -z $OH_MY_POSH_LOADED ]] && [[ "$TERM_PROGRAM" != "WarpTerminal" ]]; then
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

plugins=(git zsh-autosuggestions zsh-shift-select zsh-syntax-highlighting)

function gitf() {
    local url="$1"
    local github_token="$GITHUB_TOKEN" 

    if [[ -z "$url" ]]; then
        echo "Please provide a file or repository URL."
        return 1
    fi    
    if [[ "$url" == *"blob/"* ]]; then
        
        local raw_url="${url/blob/raw}"
        local headers=()
        if [[ -n "$github_token" ]]; then
            headers=(-H "Authorization: token $github_token")
        fi
        
        curl -sSL "${headers[@]}" "$raw_url" -o "$(basename "$raw_url")"

        if [[ $? -eq 0 ]]; then
            echo "File downloaded successfully: $(basename "$raw_url")"
        else
            echo "Failed to download the file."
            return 1
        fi
    else
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
      formatted_time = strftime("%m-%d %H:%M", timestamp)  
      printf("%s  %s\n", formatted_time, command)
    } else {
      print $0
    }
  }' ~/.zsh_history
}

alias cpb="cp -t ~/Backup/ -v"
alias history=history_with_timestamps
alias update="sudo nala update && sudo nala upgrade --full -y"
alias fm="mc"
alias py="python3.13"
alias python="python3.13"
alias ws="cd ~/Programs"
alias nano="micro"
alias dk=docker
alias ls="eza --icons=always"
alias lst="eza -T --icons=always"
alias ll="eza -l --icons=always"
alias llt="eza -l -T --icons=always"
alias m="micro"
alias shutdown="wsl.exe --shutdown"
alias reload="source ~/.zshrc"
alias top=htop
alias chrome.exe="/mnt/c/Program\ Files/Google/Chrome/Application/chrome.exe"
alias open=wslview
alias ..="cd .."
alias ni="sudo nala install"
alias bi="brew install"
alias rm="trash -fv"
alias fzf="fzf --preview='bat --color=always {}'"
alias fzc='code "$(fzf --preview="bat --color=always {}")"'
alias fzm='micro "$(fzf --preview="bat --color=always {}")"'
alias cd=z
alias cat=bat
alias dw="cd /mnt/f/Downloads"
alias c=code

export DISPLAY=:0.0

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  

alias ai="python3.12 /home/shafayet/automations/ai_cli.py --service groq"
                        
export HISTFILE=~/.zsh_history
export EDITOR=micro
export VISUAL=micro

# auto complete
# autoload -U compinit; compinit
autoload -Uz +X compinit && compinit

## case insensitive path-completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select

source ~/somewhere/fzf-tab.plugin.zsh

function set-env() {
    local var_name=$1
    local var_value=$2
    local file_env="$HOME/.env.zsh"  
    
    if [ ! -f "$file_env" ]; then
        touch "$file_env"
        echo "Created $file_env"
    fi
    
    if grep -q "^export $var_name=" "$file_env"; then
        sed -i '' "s|^export $var_name=.*|export $var_name=\"$var_value\"|" "$file_env"
        echo "Updated: export $var_name=\"$var_value\" in .env.zsh"
    else
        echo "export $var_name=\"$var_value\"" >> "$file_env"
        echo "Added: export $var_name=\"$var_value\" to .env.zsh"
    fi
    
    source "$file_env"
    echo "Environment variable '$var_name' is now permanently set."
}

source ~/.env.zsh
export PATH=$PATH:/home/shafayet/.local/bin
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
export HOMEBREW_NO_ENV_HINTS=1
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /home/shafayet/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.local/share/zsh/plugins/zsh-shift-select/zsh-shift-select.plugin.zsh
export PATH="$PATH:$HOME/.local/bin"

eval "$(zoxide init zsh)"
eval $(thefuck --alias fk)
# command_not_found_handler() { fk }

if [[ "$TERM_PROGRAM" != "vscode" ]] && [[ "$TERM_PROGRAM" != "WarpTerminal" ]] && [ -z "$TMUX" ]; then
    tmux attach-session || tmux new-session
fi

if [[ "$TERM_PROGRAM" != "WarpTerminal" ]] ; then
    clear() {
        # Disable Oh My Posh by unsetting the prompt
        unset PROMPT_COMMAND
        eval "$(oh-my-posh init zsh --clean)" # Clean option disables the prompt
        # Run the clear command
        command clear
        # Re-enable Oh My Posh
        eval "$(oh-my-posh init zsh)"
    }
fi

exit() {
  if [ -n "$TMUX" ]; then
    tmux kill-session 
  fi
  builtin exit
}



. "$HOME/.atuin/bin/env"

eval "$(atuin init zsh)"
