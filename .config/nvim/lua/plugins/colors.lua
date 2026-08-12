return {
    {
        "dracula/vim",
        lazy = false,
        name = "dracula",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("dracula")

            -- Transparency fix for ghostty on MacOS
            local transparent_groups = {
              "Normal",
              "NormalFloat",
              "SignColumn",
              "FoldColumn",
              "EndOfBuffer",
            }
            for _, group in ipairs(transparent_groups) do
              -- Set background for each transparency group to none
              -- fall back to terminal's transparency
              vim.api.nvim_set_hl(0, group, { bg = "none" })
            end
        end,
    },
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
