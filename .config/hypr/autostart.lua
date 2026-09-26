hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprpaper")
    -- Run ghostty as a systemd service so the XDG portal can resolve its app id
    -- (required for global keybinds like the quick terminal). Import the full
    -- environment so vars from the login profile (e.g. EDITOR) reach the service.
    hl.exec_cmd("dbus-update-activation-environment --systemd --all && systemctl --user start app-com.mitchellh.ghostty.service")
    hl.exec_cmd('hyprctl setcursor "Banana-Dracula" 48')
end)
