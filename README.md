# DotFiles

Home for all of my various customization things

#3 Fully Loaded Arch Set Up Dependencies (See script)

i3-gaps polybar light networkmanager blueman konsole yakuake neovim lightdm lightdm-gtk-greeter xorg-server xorg-xinput git pavucontrol arandr zsh

## Stock Programs

Display Manager: `lightdm`

Window Manger: `bspwm`

Bar: `polybar`

Bar Theme: Modified version of default polybar theme 

## Terminal Stuff

Terminal: `st`

Terminal Editor: `neovim`

Music Player: `cmus`

* Also use `spotify-tui` with `spotifyd` for spotify terminal player

__Zsh__

Manager: `OhMyZsh`

Theme: `robbyrussell`

Plugins: `git, vi-mode, zsh-autosuggestions, zsh-syntax-highlighting`


### st

* Use `tmux` for scrolling in terminal

## Vim

Version: `neovim`

Plugin Manager: `vim-plug`

Plugins 
* `vim-airline`
    * Powerline status bar

* `deoplete`
    * Tab completion

* vim-latex-live-preview
    * LaTeX live previewer
    * use `evince` as pdf viewer for no particular reason

## Utilities
Wifi Manager: `networkmanager`

Displays: `arandr` (gui version of `xrandr`, see also autorandr for slightly better hotplugging) 

Bluetooth: `blueman`

Brightness Controls: `light`

Device Config: `xinput` (used for things touchpad config; tap to click in i3, etc)

Pulseaudio Controller thing: `pavucontrol`

GTK Theme Utility: `lxappearance`
