# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/alex/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Chagne term env var
# allows tmux to use st instead of screen as default term
export TERM=st-256color

# Plugins
plugins=(
    git
    vi-mode
    zsh-autosuggestions 
    zsh-syntax-highlighting
)

# Ohmyzsh stuff
source $ZSH/oh-my-zsh.sh

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

# Aliases
alias gits="git status"
alias gitc="git commit -m"
alias suspend="i3lock --color=#454545 | systemctl suspend"
alias shutdown="systemctl poweroff"
alias vim="nvim"
alias pdflatex-s="pdflatex -shell-escape"
alias docs="cd ~/E/AlexBecker/Documents/"
alias school="cd ~/E/AlexBecker/Documents/School"
alias death_to="zsh ~/E/AlexBecker/Documents/dotfiles/scripts/death_to.sh"
alias start_spotifyd="zsh ~/E/AlexBecker/Documents/dotfiles/scripts/start_spotifyd.sh"
alias aur="zsh /home/alex/E/AlexBecker/Documents/dotfiles/scripts/aur.sh"
alias aur-rm="zsh /home/alex/E/AlexBecker/Documents/dotfiles/scripts/aur-rm.sh"
