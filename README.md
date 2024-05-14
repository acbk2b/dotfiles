# dotfiles

There's not place like `~`

# Program Configurations

- Active program configurations
    - `dunst`, `ipython` `lf`, `mutt`, `newsboat`, `nvim`, `picom`, `qtile`, `tmux`, `zathura`, `zsh`
- Inactive program configurations
    - `alacritty`, `awesome`, `bspwm`, `i3`, `polybar`, `xmonad`
- Misc configurations 
    - `users-dirs.dirs` -> Sets most `XDG_*_DIRS`
    `.xprofile` -> Runs auto-start and remap scripts
- Additional programs without configuration files
    - `arandr`
- Additional optional dependencies from other repositories
    - [dwm](https://github.com/acbk2b/dwm.git) -> My custom `dwm` build
    - [dwmblocks](https://github.com/acbk2b/dwmblocks.git) -> My custom `dwmblocks` build.
      Status bar scripts are in this repository.
    - [st](https://github.com/acbk2b/st.git) -> My custom `st` build

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
