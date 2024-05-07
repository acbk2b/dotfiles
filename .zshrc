# zshell config

# Load aliases
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"

# Set Zsh Options
HISTFILE=~/.zsh_history 
HISTSIZE=1000
SAVEHIST=1000
setopt HIST_IGNORE_SPACE
# Auto Completions
autoload -Uz compinit; compinit
# Auto cd
setopt autocd
# Fuzzy match completions for autocd and other commands
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

# Zsh Plugins
source ~/.config/zsh/vi-mode.plugin.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Starship prompt
eval "$(starship init zsh)"

# zoxide
eval "$(zoxide init zsh --cmd \"cd\")"

# Print random pokemon on shell startup
pokemon-colorscripts -r
