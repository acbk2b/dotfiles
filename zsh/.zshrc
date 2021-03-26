# zshrc

# Shell Options

# Set zsh history file
HISTFILE=~/.zsh_history 
HISTSIZE=1000
SAVEHIST=1000
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
# Use nvim for viewing man pages
export MANPAGER="nvim -c 'set ft=man' -"

# Aliases
alias cl="cal -3"
alias doas="doas --"
alias e="exit"
alias gits="git status"
alias gitc="git commit -m"
alias ls="exa --icons --group-directories-first"
alias lsl="ls -l"
alias lsal="ls -al"
alias lst="ls --tree"
alias lsa="ls -a"
alias lsat="ls -a --tree"
alias mlf="lf -doc | vim -E"
alias pdflatex-s="pdflatex -shell-escape"
alias r="ranger"
alias suspend="dm-tool lock | systemctl suspend"
alias vim="nvim"
alias xclipc="xclip -selection \"clipboard\""
alias yay="yay --sudo doas"
alias zf="zathura --fork"

# Starship prompt
eval "$(starship init zsh)"

# Plugins
source ~/.config/zsh/vi-mode.plugin.zsh 2>/dev/null
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null # Syntax highlighting goes last 
