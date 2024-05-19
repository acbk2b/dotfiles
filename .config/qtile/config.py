# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# Used for os commands
import os
# Used to get the output of os commands
import subprocess
# Used to get hostname for widget things

from typing import List  # noqa: F401

from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Screen, ScratchPad, DropDown, Match
from libqtile.lazy import lazy

home = os.path.expanduser('~')

mod = "mod4"
terminal = 'st'

cursor_warp = True

# Hacky sed thing to get the cursor warp to work
# lazy.function will flip the variable, but because the config file
# is evaluated on (re)start, it doesn't actually register the change
def toggle(self):
    os.system("bash ~/.config/qtile/mouse-warp.sh " + str(cursor_warp) + " " + str(not cursor_warp))

keys = [
    # Switch between windows in current stack pane
    Key([mod], "j", lazy.group.next_window(),
        desc="Move focus down in stack pane"),
    Key([mod], "k", lazy.group.prev_window(),
        desc="Move focus up in stack pane"),
    # Decrease master pane 
    Key([mod], "comma", lazy.layout.shrink_main(),
        desc="Decrease size of master pane"),
    # Increase master pane 
    Key([mod], "period", lazy.layout.grow_main(),
        desc="Decrease size of master pane"),

    # Move windows up or down in current stack
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(),
        desc="Move window down in current stack "),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(),
        desc="Move window up in current stack "),

    # Switch window focus to other pane(s) of stack
    Key([mod], "space", lazy.layout.next(),
        desc="Switch window focus to other pane(s) of stack"),

    # Swap panes of split stack
    Key([mod, "shift"], "space", lazy.layout.rotate(),
        desc="Swap panes of split stack"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack"),
    Key([mod], "Return", lazy.spawn(terminal + ' -e tmux'), desc="Launch terminal"),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, "shift"], "c", lazy.window.kill(), desc="Kill focused window"),

    Key([mod, "shift"], "r", lazy.restart(), desc="Restart qtile"),
    Key([mod, "shift"], "e", lazy.shutdown(), desc="Shutdown qtile"),

    # Launch Dmenu
    Key([mod], "d", lazy.spawn('dmenu_run'),
        desc="Spawn a command using dmenu"),

    # Fullscreen
    Key([mod], "f", lazy.window.toggle_fullscreen(), 
        desc='Toggle fullscreen for selected window'),

    # Toggle Bar
    Key([mod], "b", lazy.hide_show_bar(),
        desc='Toggle bar for selected monitor'),

    # Floating
    Key([mod, "shift"], "space", lazy.window.toggle_floating(),
        desc='Toggle floating for selected window'),

    # Previous Monitor
    Key([mod], "h", lazy.prev_screen(),
        desc='Switch focus to previous monitor'),
    # Next Monitor
    Key([mod], "l", lazy.next_screen(),
        desc='Switch focus to next monitor'),
    
    # Media keys
    Key([], "XF86AudioMute", lazy.spawn('pactl set-sink-mute 0 toggle'),
        desc='Mute Volume with media key'),
    Key([], "XF86AudioRaiseVolume", lazy.spawn('pactl set-sink-volume 0 +5%'),
        desc='Raise Volume with media key'),
    Key([], "XF86AudioLowerVolume", lazy.spawn('pactl set-sink-volume 0 -5%'),
        desc='Lower Volume with media key'),
    Key([], "XF86MonBrightnessUp", lazy.spawn('light -A 5%'),
        desc='Lower Volume with media key'),
    Key([], "XF86MonBrightnessDown", lazy.spawn('light -U 5%'),
        desc='Lower Volume with media key'),

    # Scratchpads and friends
    # "Scratchpad"
    Key([mod], "o", lazy.spawn(terminal + ' -c "dropdown-term"'),
        desc='Spawn floating terminal'),
    # pulsemixer
    Key([mod], "i", lazy.spawn(terminal + ' -c "dropdown-term" -e pulsemixer'),
        desc="Spawn floating terminal with pulsemixer"),
    # Pavucontrol
    Key([mod, "shift"], "i", lazy.spawn("pavucontrol"),
        desc="Spawn pavucontrol"),

    # bookmark dmenu script
    Key([mod], "y", lazy.spawn('bm -d'),
        desc='bookmark dmenu script'),

    # dmenu emoji/unicode script
    Key([mod], "u", lazy.spawn('dmenuunicode'),
        desc='dmenu emoji/unicode select script'),

    # Select and run scripts in ~/scripts using dmenu
    Key([mod], "r", lazy.spawn(home + '/scripts/run_scripts'),
        desc="Select and run scripts in ~/scripts using dmenu"),

    # Toggle Cursor Warp
    # Hacky sed script thing
    Key([mod, "shift"], "y", lazy.function(toggle), lazy.restart(),
        desc="Toggle Cursor Warp and restart Qtile"),

    # Run Passmenu dmenu script
    Key([mod], "p", lazy.spawn("passmenu"),
        desc='Run Passmenu dmenu script'),

    # Launch/Kill picom keyboard shortcuts
    Key([mod], "o", lazy.spawn("picom"),
        desc='Launch Picom'),
    Key([mod, "shift"], "o", lazy.spawn("pkill picom"),
        desc='Kill Picom'),

    # Launch Firefox
    Key([mod], "w", lazy.spawn("brave"),
        desc='Launch Firefox'),

    # Launch Spotify
    Key([mod], "s", lazy.spawn("spotify"),
        desc='Launch Spotify'),
    # Flameshot
    Key([mod, "shift"], "s", lazy.spawn("flameshot gui"),
        desc="Launch flameshot"),
]

groups = [Group(i) for i in "1234567890"]
num_pad = ["KP_End", "KP_Down", "KP_Next", "KP_Left", "KP_Begin", "KP_Right", "KP_Home", "KP_Up", "KP_Prior", "KP_Insert"]

index = 0
for i in groups:
    keys.extend([
        # mod + index of group = switch to group
        Key([mod], i.name, lazy.group[i.name].toscreen(),
            desc="Switch to group {}".format(i.name)),
        # mod + numpad key = switch to group
        Key([mod], num_pad[index], lazy.group[i.name].toscreen(),
            desc="Switch to group {}".format(i.name)),
        
        # mod1 + shift + number of group = move focused window to group
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            desc="move focused window to group {}".format(i.name)),
        # mod1 + shift + numpad_key = move focused window to group
        Key([mod, "shift"], num_pad[index], lazy.window.togroup(i.name),
            desc="move focused window to group {}".format(i.name)),
    ])
    
    index += 1

groups.append(ScratchPad("scratchpad",[
                DropDown("term", terminal),
             ])
)

keys.append(
    Key([mod], "n", lazy.group['scratchpad'].dropdown_toggle("term"),
            desc='Toggle dropdown terminal')
)

# Colors
default_foreground = '#00FF9C'
default_background = '#2E2837'
alt_foreground = '#0000FF'

layout_theme = {"border_width":2,
                "margin":6,
                "border_focus":default_foreground
               }

layouts = [
    layout.MonadTall(**layout_theme, ratio=.6, max_ratio=.95),
    layout.Max(),
    # layout.Stack(num_stacks=2),
    # Try more layouts by unleashing below layouts.
    # layout.Bsp(**layout_theme),
    # layout.Columns(),
    # layout.Matrix(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

# TODO: Clean up widget config; Default values dictionary, with one for purple, one for green

widget_defaults = dict(
    font='JetBrains Mono',
    fontsize=12,
    padding=3,
)

extension_defaults = widget_defaults.copy()

widget_purple = dict(
 background = default_background,
 foreground = default_foreground
)

widget_green = dict(
 background = default_foreground,
 foreground = default_background
)

# Note that for arrows, the foreground/background colors need to be flipped compared to the 
# widgets, so widget_purple arrow goes with widget_green widget
arrow_defaults = dict(
    text = '',
    padding = 0,
    fontsize = 21
)
                                   
# Need a separate function, doesn't work using the same list
def getWidgets():
           
    widget_list = [

                    widget.Image(**widget_purple,
                                 filename="~/.config/qtile/archlinux.png", 
                                 margin = 2),
                    widget.GroupBox(**widget_purple,
                                    active=default_foreground,
                                    this_current_screen_border=default_foreground,
                                    other_current_screen_border=alt_foreground,
                                    other_screen_border=alt_foreground),
                    widget.CurrentLayout(**widget_purple, fmt='[{}]'),
                    # Set the text color the background to hide the text
                    # TODO: Remove widget, smashes all the remaining widgets together if removed
                    widget.WindowName(**widget_purple, max_chars=50),
                    widget.CheckUpdates(**widget_purple, 
                                        colour_have_updates=widget_purple['foreground'],
                                        update_interval=7200,
                                        custom_command='yay -Qu'),
                    widget.TextBox(**arrow_defaults, **widget_purple),
                    widget.Volume(**widget_green),
                    widget.TextBox(**arrow_defaults, **widget_green),
                    widget.CPU(**widget_purple, update_interval=5),
                    widget.TextBox(**arrow_defaults, **widget_purple),
                    widget.Memory(**widget_green, update_interval=5),
                    widget.TextBox(**arrow_defaults, **widget_green),
                    widget.Clock(**widget_purple, 
                                 mouse_callbacks={'Button1':lambda qtile: qtile.cmd_spawn("alacritty --hold --class 'dropdown-term'  -e 'cal' '-3'")},
                                 format='%m-%d-%Y %a %H:%M %p'),
                    widget.Systray(**widget_purple)
                ]

    # Replace CPU widget with Battery widget on laptop
    # Check for existence of a battery
    has_bat = subprocess.check_output("ls /sys/class/power_supply | grep -c 'BAT' || true", shell=True)

    if int(has_bat) > 0:
        # Find CPU module location
        index = 0
        for index in range(len(widget_list)):
            if isinstance(widget_list[index], widget.cpu.CPU):
                break 
        # Replace module
        widget_list[index] = widget.Battery(**widget_purple, format='{char} {percent:2.0%}')

    return widget_list

widgets = getWidgets()

screens = [Screen(top=bar.Bar(widgets=widgets, size=19))]

num_screens = int(subprocess.check_output("xrandr | grep -w -c 'connected'", shell=True))

# Just want the groupbox and the layout name
alt_mon_widgets = getWidgets()[:-1]

# There will be one connected display for them main display,
# only want to add bars for any additional screens
for i in range(num_screens-1):
    screens.append(Screen(top=bar.Bar(widgets=alt_mon_widgets, size=19)))

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
# main = None  # WARNING: this is deprecated and will be removed soon
follow_mouse_focus = True
bring_front_click = False

floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class='confirmreset'),  # gitk
        Match(wm_class='makebranch'),  # gitk
        Match(wm_class='maketag'),  # gitk
        Match(wm_class='ssh-askpass'),  # ssh-askpass
        Match(title='branchdialog'),  # gitk
        Match(title='pinentry'),  # GPG key password entry
        Match(wm_class='pinentry-gtk-2'),  # GPG key password entry
        Match(wm_class='dropdown-term'),  # pulsemixer/other pop-up terminal things
        Match(wm_class='pavucontrol'),  # Pavucontrol (Pulseaudio Volume Control)
        Match(wm_class='arandr'),  # arandr
        Match(wm_class='Variety'),  # arandr
    ],
    **layout_theme
)
auto_fullscreen = True
focus_on_window_activation = "smart"

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
