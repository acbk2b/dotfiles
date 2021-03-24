# zshrc

# OhMyZsh stuff

# Path to your oh-my-zsh installation.
export ZSH="/home/alex/.oh-my-zsh"
export PATH=$PATH:/home/alex/.local/bin

# Zsh prompt theme
ZSH_THEME="robbyrussell"

# Plugins
plugins=(
    git
    vi-mode
    # zsh-vi-mode
    zsh-autosuggestions 
    zsh-syntax-highlighting
    zsh-completions
)

autoload -U compinit; compinit

# Ohmyzsh stuff
source $ZSH/oh-my-zsh.sh

# Misc exports

# Default editor to neovim
export EDITOR='nvim'

# change term env var
# allows tmux to use st instead of screen as default term
export TERM=st-256color

# Use bat for viewing man pages
export MANPAGER="nvim -c 'set ft=man' -"

# Pywal color scheme
# (cat ~/.cache/wal/sequences &)

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
alias lst="ls --tree"
alias lsa="ls -a"
alias lsat="ls -a --tree"
alias e="exit"
alias r="ranger"
alias cl="cal -3"
alias xclipc="xclip -selection \"clipboard\""
alias zf="zathura --fork"

# tabtab source for electron-forge package
# uninstall by removing these lines or running `tabtab uninstall electron-forge`
[[ -f /home/alex/Documents/school/MST/senior-year/cs4096/test-proj/node_modules/tabtab/.completions/electron-forge.zsh ]] && . /home/alex/Documents/school/MST/senior-year/cs4096/test-proj/node_modules/tabtab/.completions/electron-forge.zsh
