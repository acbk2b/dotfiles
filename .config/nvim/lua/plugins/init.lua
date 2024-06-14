-- Vim-Plug plugin configuration

-- Load Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    { 'christoomey/vim-tmux-navigator' },
    { 'dracula/vim', lazy = true, name = 'dracula' },
    { 'easymotion/vim-easymotion' },
    { 'mechatroner/rainbow_csv' },
    { 'neovim/nvim-lspconfig' },
    { 'hrsh7th/nvim-cmp' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'L3MON4D3/LuaSnip' },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'nvim-tree/nvim-tree.lua', lazy = true, },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function ()
            local configs = require('nvim-treesitter.configs')
            configs.setup(require('plugins/treesitter'))
        end
    },
    { 'tpope/vim-commentary' },
    { 'tpope/vim-surround' },
    { 'vim-airline/vim-airline' },
    { 'vimwiki/vimwiki' },
}

-- Add any options for Lazy here
local opts = {}

require('lazy').setup(plugins, opts)

-- Plugin configuration setup
require('plugins/airline')
require('lsp')
require('plugins/nvim-tree')
require('plugins/vimwiki')
-- Load WSL config if running on WSL
if vim.fn.has('wsl') == 1 then
    require('wsl-stuff')
end
