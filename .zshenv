# Launch tmux on zsh startup
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    exec tmux
fi
