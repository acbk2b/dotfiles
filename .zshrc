# zshell config

# Load aliases
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"

# Misc zsh Options
HISTFILE=~/.zsh_history 
HISTSIZE=1000
SAVEHIST=1000
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
# Auto Completions
autoload -Uz compinit; compinit
# Auto cd
setopt autocd
# zstyle
# Fuzzy match completions for autocd and other commands
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

# Prompt options
# Enable colors
autoload -U colors && colors
# Configuration for showing current git branch
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b'
setopt prompt_subst

# Set prompt
PS1='%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]$fg[green](${vcs_info_msg_0_})
$%{$reset_color%}%b '

# Keybinds
bindkey '^f' autosuggest-accept
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# Zsh Plugins
# System plugins
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# User plugins
source ~/.config/zsh/vi-mode.plugin.zsh 2>/dev/null

# evals
# zoxide
eval "$(zoxide init zsh --cmd \"cd\")"

# Print random pokemon on shell startup
pokemon-colorscripts -r
