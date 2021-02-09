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
import socket

from typing import List  # noqa: F401

from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Screen, ScratchPad, DropDown
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from libqtile.log_utils import logger # For Writing output to qtile.log

# from libqtile.core.manager.Qtile import cmd_display_kb

home = os.path.expanduser('~')

mod = "mod4"
terminal = 'alacritty'

cursor_warp = True

# Hacky sed thing to get the cursor warp to work
# lazy.function will flip the variable, but because the config file
# is evaluated on (re)start, it doesn't actually register the change
def toggle(self):
    os.system("bash ~/.config/qtile/external.sh " + str(cursor_warp) + " " + str(not cursor_warp))

keys = [
    # Switch between windows in current stack pane
    Key([mod], "j", lazy.layout.down(),
        desc="Move focus down in stack pane"),
    Key([mod], "k", lazy.layout.up(),
        desc="Move focus up in stack pane"),
    # Increase master pane 
    Key([mod, "shift"], "l", lazy.layout.grow_main(),
        desc="Decrease size of master pane"),
    # Decrease master pane 
    Key([mod, "shift"], "h", lazy.layout.shrink_main(),
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
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, "shift"], "c", lazy.window.kill(), desc="Kill focused window"),

    Key([mod, "shift"], "r", lazy.restart(), desc="Restart qtile"),
    Key([mod, "shift"], "e", lazy.shutdown(), desc="Shutdown qtile"),

    # Launch Dmenu
    Key([mod, "shift"], "d", lazy.spawn('dmenu_run'),
        desc="Spawn a command using dmenu"),
    # Launch Rofi
    Key([mod], "d", lazy.spawn('rofi -show drun -show-icons'),
        desc="Spawn an app using a rofi"),


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
    Key([mod], "i", lazy.spawn("st -c \"st-dropdown\" -e pulsemixer"),
        desc="Spawn floating terminal with pulsemixer"),

    # Select and run scripts in ~/scripts using dmenu
    Key([mod], "r", lazy.spawn(home + '/scripts/run_scripts'),
        desc="Select and run scripts in ~/scripts using dmenu"),

    # Flameshot
    Key([mod, "shift"], "s", lazy.spawn("flameshot gui"),
        desc="Launch flameshot"),

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
    
    # Toggle Cursor Warp
    # Hacky sed script thing
    Key([mod], "y", lazy.function(toggle), lazy.restart(),
        desc="Toggle Cursor Warp and restart Qtile"),

    # Lock screen with display manager tool thing
    Key([mod, "shift"], "x", lazy.spawn("dm-tool lock"),
        desc='Lock Screen with dm-tool'),

    # Run Passmenu dmenu script
    Key([mod], "p", lazy.spawn("passmenu"),
        desc='Run Passmenu dmenu script'),

    # Launch/Kill picom keyboard shortcuts
    Key([mod], "o", lazy.spawn("picom"),
        desc='Launch Picom'),
    Key([mod, "shift"], "o", lazy.spawn("pkill picom"),
        desc='Kill Picom'),

    # Work in progress
    # Key([mod], "s", lazy.function(), 
    #     desc='Display keybindings'),

]

groups = [Group(i) for i in "123456789"]
# groups.append(ScratchPad("scratchpad", [
#                          DropDown("term", terminal),
#                          ]))

num_pad = ["KP_End", "KP_Down", "KP_Next", "KP_Left", "KP_Begin", "KP_Right", "KP_Home", "KP_Up", "KP_Prior"]

index = 0
for i in groups:
    keys.extend([
        # mod + index of group = switch to group
        Key([mod], i.name, lazy.group[i.name].toscreen(),
            desc="Switch to group {}".format(i.name)),
        # mod + numpad key = switch to group
        Key([mod], num_pad[index], lazy.group[i.name].toscreen(),
            desc="Switch to group {}".format(i.name)),


        # # mod1 + shift + letter of group = switch to & move focused window to group
        # Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True),
        #     desc="Switch to & move focused window to group {}".format(i.name)),
        # # mod + shift + numpad key = switch to and move focused window to group
        # Key([mod, "shift"], num_pad[index], lazy.window.togroup(i.name, switch_group=True),
        #     desc="Switch to & move focused window to group {}".format(i.name)),

        # Or, use below if you prefer not to switch to that group.
        # mod1 + shift + letter of group = move focused window to group
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            desc="move focused window to group {}".format(i.name)),
        Key([mod, "shift"], num_pad[index], lazy.window.togroup(i.name),
            desc="move focused window to group {}".format(i.name)),

    ])

    index += 1

# Colors
default_foreground = '#00FF9C'
default_background = '#2E2837'
alt_foreground = '#82AAFF'

layout_theme = {"border_width":2,
                "margin":6,
                "border_focus":default_foreground
               }

layouts = [
    layout.MonadTall(**layout_theme),
    layout.Max(),
    # layout.Stack(num_stacks=2),
    # Try more layouts by unleashing below layouts.
    layout.Bsp(**layout_theme),
    # layout.Columns(),
    # layout.Matrix(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font='Ubunto Mono',
    fontsize=12,
    padding=3,
)

extension_defaults = widget_defaults.copy()

# Need a separate function, doesn't work using the same list
def getWidgets():
           
    widget_list = [

                    widget.Image(filename="~/.config/qtile/archlinux.png", 
                                 background=default_background, 
                                 foreground=default_foreground,
                                 margin = 2),
                    widget.GroupBox(active=default_foreground,
                                    background=default_background, 
                                    foreground=default_foreground,
                                    this_current_screen_border=default_foreground),
                    widget.CurrentLayout(background=default_background, foreground=default_foreground),
                    # Set the text color the background to hide the text
                    # TODO: Remove widget, smashes all the remaining widgets together if removed
                    widget.WindowName(background=default_background, foreground=default_background),
                    widget.Chord(
                        chords_colors={'launch': ("#ff0000", "#ffffff"),},
                        name_transform=lambda name: name.upper(),),
                    widget.TextBox(
                                   text = '',
                                   background = default_background,
                                   foreground = default_foreground,
                                   padding = 0,
                                   fontsize = 35),

                    widget.Volume(
                                  background=default_foreground,
                                  foreground=default_background),
                    widget.TextBox(
                                   text = '',
                                   background = default_foreground,
                                   foreground = default_background,
                                   padding = 0,
                                   fontsize = 35),
                    widget.CPU(background=default_background, foreground=default_foreground),
                    widget.TextBox(
                                   text = '',
                                   background = default_background,
                                   foreground = default_foreground,
                                   padding = 0,
                                   fontsize = 35),
                    widget.Memory(background=default_foreground, foreground=default_background),
                    widget.TextBox(
                                   text = '',
                                   background = default_foreground,
                                   foreground = default_background,
                                   padding = 0,
                                   fontsize = 35),
                    widget.Clock(background=default_background, 
                                 foreground=default_foreground, 
                                 format='%m-%d-%Y %a %I:%M %p'),
                    widget.Systray(background=default_background, foreground=default_foreground)
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
        widget_list[index] = widget.Battery(background=default_background, foreground=default_foreground, format='{char} {percent:2.0%}')

    return widget_list

widgets = getWidgets()

screens = [Screen(top=bar.Bar(widgets=widgets, size=20))]

num_screens = int(subprocess.check_output("xrandr | grep -w -c 'connected'", shell=True))

# Just want the groupbox and the layout name
alt_mon_widgets = widgets[:2] 

# There will be one connected display for them main display,
# only want to add bars for any additional screens
for i in range(num_screens-1):
    screens.append(Screen(top=bar.Bar(widgets=alt_mon_widgets, size=20)))

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

floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},  # gitk
    {'wmclass': 'makebranch'},  # gitk
    {'wmclass': 'maketag'},  # gitk
    {'wname': 'branchdialog'},  # gitk
    {'wname': 'pinentry'},  # GPG key password entry
    {'wmclass': 'pinentry-gtk-2'},  # GPG key password entry
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
    # {'wmclass': 'Steam'},  # Steam
    {'wmclass': 'pavucontrol'},  # Pavucontrol
    {'wmclass': 'st-dropdown'},  # Pavucontrol
])
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

@hook.subscribe.startup_once
def autostart():
    os.system(home + '/.config/qtile/autostart.sh')
