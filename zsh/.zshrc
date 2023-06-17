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

# Aliases
alias cl="cal -3"
alias gitdb="git diff | diff-so-fancy | bat"
alias e="exit"
alias gitp="git push"
alias gits="git status"
alias gitc="git commit -m"
alias ipy="ipython"
alias lf="$HOME/.local/bin/lfub"
alias l="ls -al"
alias ls="exa --group-directories-first"
alias ll="ls -l"
alias lst="ls --tree"
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
