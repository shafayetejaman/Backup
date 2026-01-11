
# ~/.zshrc - Full Ghostty/Omerchy + minimal tmux setup

# ------------------------------------------
# Only run in interactive shells
[[ $- != *i* ]] && return

# Load environment (your existing env file)
. "$HOME/.local/share/../bin/env"

# Load omarchy-zsh configuration
if [[ -d /usr/share/omarchy-zsh/conf.d ]]; then
  for config in /usr/share/omarchy-zsh/conf.d/*.zsh; do
    [[ -f "$config" ]] && source "$config"
  done
fi

# Load omarchy-zsh functions and aliases
if [[ -d /usr/share/omarchy-zsh/functions ]]; then
  for func in /usr/share/omarchy-zsh/functions/*.zsh; do
    [[ -f "$func" ]] && source "$func"
  done
fi

# Load Starship prompt if not already loaded
type starship_zle-keymap-select >/dev/null || {
    echo "Loading Starship..."
    eval "$(/usr/local/bin/starship init zsh)"
}

# ------------------------------------------
# GTK/Qt scaling (optional)
export GDK_SCALE=2
export GDK_DPI_SCALE=0.5
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export QT_SCALE_FACTOR=2
export QT_FONT_DPI=192
export XCURSOR_SIZE=48
export MOZ_ENABLE_WAYLAND=1

# ------------------------------------------
# Plugins
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^N' autosuggest-accept
autoload -U compinit; compinit
source ~/somewhere/fzf-tab.plugin.zsh
source ~/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
eval $(thefuck --alias fk)

# ------------------------------------------
# Aliases
alias reload="source ~/.zshrc"
alias vi="nvim"
alias vim="nvim"
alias nano="nvim"
alias rm="trash-put"
alias py="python3.13"
alias python="python3.13"
alias cat=bat
alias gw="$HOME/Work"
alias sudo='sudo '

# ------------------------------------------
# Functions
fs() {
    eval "sudo $(fc -ln -1)"
}

# ------------------------------------------
# --- Minimal tmux auto-attach ---


if [[ -n $PS1 ]] && [[ -z $TMUX ]]; then
    session="main"

    # Create session if it doesn't exist
    tmux has-session -t $session 2>/dev/null || tmux new-session -d -s $session

    # Attach session, detaching other clients if needed
    exec tmux attach-session -d -t $session
fi
