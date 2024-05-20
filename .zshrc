# zshell config

# zinit setup
ZINIT_HOME="${XDG_DATA_HOME:-${HOME/.local/share}}/zinit/zinit.git"

# Load aliases
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"

# Download zinit if it does not exist
if [ ! -d "${ZINIT_HOME}" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Load zinit
source "${ZINIT_HOME}"/zinit.zsh

# Plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
# ohmyzsh vi mode plugin
zinit snippet OMZP::vi-mode

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
# Disable default completion menu
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls $realpath'

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

# zoxide
eval "$(zoxide init zsh --cmd \"cd\")"

# fzf
eval "$(fzf --zsh)"

# Print random pokemon on shell startup
pokemon-colorscripts -r
