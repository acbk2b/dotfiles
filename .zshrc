# zshrc -> Contains all shell options/config

# Set Shell Options
# Set zsh history file
HISTFILE=~/.zsh_history 
HISTSIZE=1000
SAVEHIST=1000
setopt HIST_IGNORE_SPACE
# Auto Completions
autoload -Uz compinit; compinit
# Auto cd
setopt autocd
# Fuzzy match completions
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
# Default editor to neovim
export EDITOR='nvim'
# change term env var
# Use nvim for viewing man pages
export MANPAGER='nvim +Man!'
export MANWIDTH=999
# Add ~/.local/bin to $PATH
export PATH="${PATH}:$HOME/.local/bin/"
# Aliases
alias cl="cal -3"
alias gita="git add"
alias gitc="git commit -m"
alias gitd="git diff"
alias gitl="git log"
alias gitr="git restore --staged"
alias gits="git status"
alias ipy="ipython"
# LF wrapper script
alias lf="$HOME/.local/bin/lfub"
alias ls="exa --group-directories-first --icons"
alias l="ls -al"
alias ll="ls -l"
alias lst="ls --tree"
alias pdflatexs="pdflatex -shell-escape"
alias pkmn="clear; pokemon-colorscripts -r"
alias vim="nvim"
alias xclipc="xclip -selection \"clipboard\""
alias zf="zathura --fork"
# Plugins
source ~/.config/zsh/vi-mode.plugin.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# Starship prompt
eval "$(starship init zsh)"
# zoxide
eval "$(zoxide init zsh)"
# Print random pokemon on shell startup
pokemon-colorscripts -r
source /usr/share/nvm/init-nvm.sh
