local terminal = "ghostty"
local menu = "rofi -show drun"
local browser = "brave"
local main_mod = "SUPER"

-- Navigation keybindings
hl.bind(main_mod .. " + Return", hl.dsp.exec_cmd(terminal .. " -e tmux"))
hl.bind(main_mod .. " + grave", hl.dsp.workspace.toggle_special("scratchpad"))
hl.bind(main_mod .. " + w", hl.dsp.window.close())
hl.bind(main_mod .. " + SHIFT + e", hl.dsp.exit())
hl.bind(main_mod .. " + SHIFT + Space", hl.dsp.window.float({ action = "toggle" }))
hl.bind(main_mod .. " + Space", hl.dsp.exec_cmd(menu))
hl.bind(main_mod .. " + p", hl.dsp.window.pseudo())
hl.bind(main_mod .. " + j", hl.dsp.layout("togglesplit"))

hl.bind(main_mod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(main_mod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(main_mod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(main_mod .. " + down", hl.dsp.focus({ direction = "down" }))

hl.bind(main_mod .. " + h", hl.dsp.focus({ direction = "l" }))
hl.bind(main_mod .. " + l", hl.dsp.focus({ direction = "r" }))
hl.bind(main_mod .. " + k", hl.dsp.focus({ direction = "u" }))
hl.bind(main_mod .. " + j", hl.dsp.focus({ direction = "d" }))

hl.bind("SUPER + SHIFT + h", hl.dsp.window.swap({ direction = "l" }))
hl.bind("SUPER + SHIFT + l", hl.dsp.window.swap({ direction = "r" }))
hl.bind("SUPER + SHIFT + k", hl.dsp.window.swap({ direction = "u" }))
hl.bind("SUPER + SHIFT + j", hl.dsp.window.swap({ direction = "d" }))

-- Workspaces
for i = 1, 10 do
    local key = i % 10
    hl.bind(main_mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(main_mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Scratchpad keybinding
hl.bind(main_mod .. " + S", hl.dsp.workspace.toggle_special("magic"))

-- Lock screen w/ hyprlock
hl.bind(main_mod .. " + CONTROL + q", hl.dsp.exec_cmd("hyprlock"))

hl.bind(main_mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(main_mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(main_mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(main_mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Media keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
    { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 10%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"), { locked = true, repeating = true })

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- App bindings
hl.bind(main_mod .. " + b", hl.dsp.exec_cmd(browser))
hl.bind(main_mod .. " + p", hl.dsp.exec_cmd("spotify"))
hl.bind(main_mod .. " + CONTROL + SHIFT + 4", hl.dsp.exec_cmd("flameshot gui"))

-- Helper scripts
hl.bind(main_mod .. " + y", hl.dsp.exec_cmd("bm -d"))
hl.bind(main_mod .. " + u", hl.dsp.exec_cmd("dmenuunicode -d"))
