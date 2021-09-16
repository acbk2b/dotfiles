# zshrc

# Shell Options

# export PATH="${PATH}:.local/bin/"

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
alias e="exit"
alias gits="git status"
alias gitc="git commit -m"
alias ls="exa --group-directories-first"
alias lsl="ls -l"
alias lsal="ls -al"
alias lst="ls --tree"
alias lsa="ls -a"
alias lsat="ls -a --tree"
alias mlf="lf -doc | vim -E"
alias pdflatexs="pdflatex -shell-escape"
alias suspend="dm-tool lock | systemctl suspend"
alias vim="nvim"
alias xclipc="xclip -selection \"clipboard\""
alias zf="zathura --fork"

# Starship prompt
eval "$(starship init zsh)"

# Plugins
# https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/vi-mode/vi-mode.plugin.zsh
source ~/.config/zsh/vi-mode.plugin.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

pokemon-colorscripts -r
