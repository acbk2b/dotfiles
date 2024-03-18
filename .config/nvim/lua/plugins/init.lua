-- Vim-Plug plugin configuration

vim.call('plug#begin', '~/.config/nvim/data/plugged')

-- Coc
vim.fn['plug#']('neoclide/coc.nvim', { branch = 'release' })
-- Commentary
vim.fn['plug#']('tpope/vim-commentary')
-- Dracula Color Scheme
vim.fn['plug#']('dracula/vim', { as = 'dracula' })
-- Easy Motion
vim.fn['plug#']('easymotion/vim-easymotion')
-- Nvim Tree
vim.fn['plug#']('nvim-tree/nvim-tree.lua')
-- Rainbow CSV
vim.fn['plug#']('mechatroner/rainbow_csv')
-- surround.vim
vim.fn['plug#']('tpope/vim-surround')
-- Treesitter -> Better syntax highlighting
vim.fn['plug#']('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
-- Vim-Airline Statusbar
vim.fn['plug#']('vim-airline/vim-airline')
-- Vimwiki
vim.fn['plug#']('vimwiki/vimwiki')

vim.call('plug#end')

-- Plugin configuration source files
require('plugins/coc-config')
require('plugins/nvim-tree')
require('plugins/treesitter-config')
require('plugins/vimwiki')
-- Load WSL config if running on WSL
if vim.fn.has('wsl') == 1 then
    require('wsl-stuff')
end

-- Vim Airline Theme Stuff
vim.g.airline_powerline_fonts = 1
