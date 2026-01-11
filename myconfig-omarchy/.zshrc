# If not running interactively, don't do anything
[[ $- != *i* ]] && return

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

# Add your own customizations below

# GTK (GNOME, apps using GTK)
export GDK_SCALE=2
export GDK_DPI_SCALE=0.5

# Qt (KDE, Qt apps)
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export QT_SCALE_FACTOR=2
export QT_FONT_DPI=192

# Cursor scaling
export XCURSOR_SIZE=48

# Firefox (Wayland)
export MOZ_ENABLE_WAYLAND=1

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^N' autosuggest-accept
autoload -U compinit; compinit
source ~/somewhere/fzf-tab.plugin.zsh
source /home/shafayet/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
eval $(thefuck --alias fk)

alias reload="source .zshrc"
alias vi="nvim"
alias vim="nvim"
alias nano="nvim"
alias rm="trash-put"
alias py="python3.13"
alias python="python3.13"
alias cat=bat
alias gw="/home/shafayet/Work"
alias sudo='sudo '

fs() {
    eval "sudo $(fc -ln -1)"
}

# Check that the function `starship_zle-keymap-select()` is defined.
# xref: https://github.com/starship/starship/issues/3418
type starship_zle-keymap-select >/dev/null || \
  {
    echo "Load starship"
    eval "$(/usr/local/bin/starship init zsh)"
  }
