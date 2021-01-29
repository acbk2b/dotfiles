# zshrc

# Path to your oh-my-zsh installation.
export ZSH="/home/alex/.oh-my-zsh"
export PATH=$PATH:/home/alex/.local/bin

# Zsh prompt theme
ZSH_THEME="robbyrussell"

# change term env var
# allows tmux to use st instead of screen as default term
export TERM=st-256color

# thefuck
eval $(thefuck --alias)

# Plugins
plugins=(
    git
    vi-mode
    zsh-autosuggestions 
    zsh-syntax-highlighting
    zsh-completions
)

autoload -U compinit; compinit

# Ohmyzsh stuff
source $ZSH/oh-my-zsh.sh

export EDITOR='nvim'

# Aliases
alias gits="git status"
alias gitc="git commit -m"
alias suspend="dm-tool lock | systemctl suspend"
alias vim="nvim"
alias pdflatex-s="pdflatex -shell-escape"
alias ls="exa"
alias lsl="ls -l"
alias lst="ls --tree"
alias lsa="ls -a"
alias lsat="ls -a --tree"
alias e="exit"
alias r="ranger"
alias cl="cal -3"
alias xclipc="xclip -selection \"clipboard\""
alias zf="zathura --fork"

# Starship prompt
eval $(starship init zsh)
