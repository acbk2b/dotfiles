hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprpaper")
    -- Run ghostty as a systemd service so the XDG portal can resolve its app id
    -- (required for global keybinds like the quick terminal)
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP HYPRLAND_INSTANCE_SIGNATURE && systemctl --user start app-com.mitchellh.ghostty.service")
    hl.exec_cmd('hyprctl setcursor "Banana-Dracula" 48')
end)
