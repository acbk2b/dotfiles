require'nvim-treesitter.configs'.setup {
    -- Automatically install missing parsers when entering buffer
    auto_install = true,
    -- Highlight settings
    highlight = {
        -- Enable extension globally
        enable = true,
        -- Disable treesitter for specific file types
        disable = { "csv" },
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        additional_vim_regex_highlighting = false,
    },
}
