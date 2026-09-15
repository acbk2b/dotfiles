return {
    plugin = {
        "dracula/vim",
        name = "dracula",
        lazy = false,
        priority = 1000,
    },

    colorscheme = "dracula",
    configure = function()
       vim.api.nvim_set_hl(0, "@markup.heading", { link = "Title" })
       vim.api.nvim_set_hl(0, "@markup.raw", { link = "DraculaPink" })
       vim.api.nvim_set_hl(0, "@markup.list", { link = "Normal" })
    end,
}
