return {
    {
        "saghen/blink.cmp",
        -- Release tags ship prebuilt fuzzy-matcher binaries (no cargo build needed)
        version = "1.*",
        event = { "InsertEnter", "CmdlineEnter" },
        dependencies = { "rafamadriz/friendly-snippets" },
        opts = {
            keymap = {
                preset = "enter",
                -- Tab cycles the menu when open, otherwise jumps snippet placeholders
                ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
                ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
            },
            appearance = {
                nerd_font_variant = "mono",
            },
            completion = {
                -- Mirror old `completeopt=noselect`: nothing preselected, insert on cycle
                list = { selection = { preselect = false, auto_insert = true } },
                menu = { border = "rounded" },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 200,
                    window = { border = "rounded" },
                },
                ghost_text = { enabled = false },
            },
            signature = {
                enabled = true,
                window = { border = "rounded" },
            },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
            },
            fuzzy = { implementation = "prefer_rust_with_warning" },
        },
        opts_extend = { "sources.default" },
    },
}
