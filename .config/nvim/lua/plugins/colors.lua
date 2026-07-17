return {
    { "dracula/vim", lazy = true, name = "dracula", priority = 1000 },
    {
        "nvim-treesitter/nvim-treesitter", -- Syntax highlighting
        lazy = false,
        branch = "main",
        build = ":TSUpdate",
        config = function()
            local treesitter_group = vim.api.nvim_create_augroup("UserTreesitter", { clear = true })
            vim.api.nvim_create_autocmd('FileType', {
                group = treesitter_group,
                pattern = { 'go', 'lua', 'python', 'sh', 'groovy', 'java', 'yaml', 'sql' },
                callback = function() vim.treesitter.start() end,
            })
        end,
    },
}
