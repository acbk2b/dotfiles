# zshrc

# Set zsh history file
HISTFILE=~/.zsh_history

export PATH=$PATH:/home/alex/.local/bin

# Auto Completions
autoload -Uz compinit; compinit
# Auto cd
setopt autocd
# Fuzzy match completions
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'


# Misc exports

# Default editor to neovim
export EDITOR='nvim'

# change term env var
# allows tmux to use st instead of screen as default term
export TERM=st-256color

# Use bat for viewing man pages
export MANPAGER="nvim -c 'set ft=man' -"

# Aliases
alias doas="doas --"
alias yay="yay --sudo doas"
alias gits="git status"
alias gitc="git commit -m"
alias suspend="dm-tool lock | systemctl suspend"
alias vim="nvim"
alias pdflatex-s="pdflatex -shell-escape"
alias ls="exa --icons --group-directories-first"
alias lsl="ls -l"
alias lsal="ls -al"
alias lst="ls --tree"
alias lsa="ls -a"
alias lsat="ls -a --tree"
alias e="exit"
alias r="ranger"
alias cl="cal -3"
alias xclipc="xclip -selection \"clipboard\""
alias zf="zathura --fork"

# Starship prompt
eval "$(starship init zsh)"

# Plugins
source ~/.config/zsh/vi-mode.plugin.zsh 2>/dev/null
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null # Syntax highlighting goes last
