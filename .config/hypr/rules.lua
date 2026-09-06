hl.window_rule({
    name = "termscratch",
    match = {
        class = "com.term.scratchpad",
    },
    workspace = "special:scratchpad silent",
    float = true,
    size = "80% 85%",
    center = true,
})

hl.window_rule({
    name = "windowrule-1",
    match = {
        class = ".*",
    },
    suppress_event = "maximize",
})

hl.window_rule({
    name = "windowrule-2",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },
    no_focus = true,
})

hl.window_rule({
    name = "windowrule-3",
    match = {
        class = "^(flameshot)$",
    },
    move = "0 0",
    pin = true,
    fullscreen_state = "2 2",
})

hl.window_rule({
    name = "windowrule-4",
    match = {
        class = "(flameshot)",
        title = "(flameshot)",
    },
    float = true,
})

hl.window_rule({
    name = "windowrule-5",
    match = {
        class = "^(flameshot)$",
    },
    no_anim = true,
})

hl.window_rule({
    name = "term-popup-float",
    match = {
        class = "^(com.term.(wiremix|htop))$",
    },
    float = true,
})

hl.window_rule({
    name = "blueman-manager-float",
    match = {
        class = "^(blueman-manager)$",
    },
    float = true,
})
