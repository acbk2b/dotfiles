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
    { 'neoclide/coc.nvim', branch = 'release', },
    { 'nvim-tree/nvim-tree.lua', lazy = true, },
    { 'tpope/vim-commentary' },
    { 'dracula/vim', lazy = true, name = 'dracula' },
    { 'easymotion/vim-easymotion' },
    { 'mechatroner/rainbow_csv' },
    { 'tpope/vim-surround' },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function ()
            local configs = require('nvim-treesitter.configs')
            configs.setup(require('plugins/treesitter'))
        end
    },
    { 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' } },
    { 'vimwiki/vimwiki' },
}

local opts = {}

require('lazy').setup(plugins, opts)

-- Plugin configuration setup
require('plugins/coc-config')
require('plugins.nvim-tree')
require('plugins.vimwiki')
require('lualine').setup()
-- Load WSL config if running on WSL
if vim.fn.has('wsl') == 1 then
    require('wsl-stuff')
end