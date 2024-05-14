# dotfiles

There's not place like `~`

# Software I Use

## Main Stuff

Distribution
- `Arch Linux`

Terminal
- `st` -> [My custom build](https://github.com/acbk2b/st.git).  I use `st` in conjunction with `tmux`, which handles copying text, scroll back, etc
- I also have an `alacritty` configuration in this repository as well, which I use without `tmux`

Shell
- `zsh`

Window Manager
- I flip back and forth between `dwm` and `qtile`.  My `qtile` configuration is in this repository, I have a [custom dwm build](https://github.com/acbk2b/dwm.git).  For `dwm`, I have [a `dwmblocks` build](https://github.com/acbk2b/dwmblocks.git) for my status bar

Text editor
- `neovim`

## Utilities

Audio
- `audacity` for recording/tracking
- `pulsemixer` for general audio management

Documents
- `latex` for putting together "official" looking papers/presentations/documents.  I just use `markdown` for general notes and things like that

File management

Image viewer
- `feh`

Notifications
- `dunst`

PDF Viewer
- `zathura` with the `zathura-pdf-poppler` add-on

RSS Reader
- `newsboat`

Spreadsheets
- `R` for formulas/statistics
- `sc-im` for editing CSVs

Misc configurations 
- `users-dirs.dirs` -> Sets most `XDG_*_DIRS`
- `.xprofile` -> Runs auto-start and remap scripts

# Scripts

- `autostart`, `remaps` -> Loaded in `.xprofile`
- `bm` -> Bookmarks script
    - Search for a bookmark using `fzf` and copy to clipboard
    - Loads all files in `$HOME/.local/share/bookmarks/`
        - My main file is symlinked from `zettelkasten/.local/bookmarks/bookmarks`
    - Bookmarks file format: `tag "url"`
    - Optionally run as a `dmenu` script with the `-d` flag
- `dmenuunicode` -> Emoji copy script from `LukeSmith`
    - Loads all files in `$HOME/.local/share/chars`
- `lfub` -> `lf` wrapper script for image previews from `LukeSmith`
- `linkhandler` -> URL loader script used by `newsboat` for opening URLs
- `remaps` -> Script for remapping keys, setting key speed rate, etc
- `sb-battery` -> `dwmblocks` status bar script for checking the battery
    - If a battery is present, it will output: `Status: Percentage%`

# Installing

`packages.csv` contains a list of all packages.
This file also contains a column for packages for setting up games (TODO add as optional part of install script)
Each column represents a different distribution's packages, with the header row contains the distribution name.
This repository is designed to be installed using `stow` (TODO full install script).
Once installed, `stow` can be run with `-t` to target `$HOME`:

```
stow . -t $HOME
```
