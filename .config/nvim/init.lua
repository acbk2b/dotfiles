-- NVim lua config file
-- 
HOME = os.getenv("HOME")

--
-- Vim-Plug plugin configuration
--

vim.call('plug#begin', '~/.config/nvim/data/plugged')

-- Vim-Airline
vim.fn['plug#']('vim-airline/vim-airline')
-- Coc
vim.fn['plug#']('neoclide/coc.nvim', { branch = 'release' })
-- Dracula Color Scheme
vim.fn['plug#']('dracula/vim', { as = 'dracula' })
-- Markdown
-- https://github.com/preservim/vim-markdown
vim.fn['plug#']('godlygeek/tabular')
vim.fn['plug#']('preservim/vim-markdown')
-- Easy Motion
vim.fn['plug#']('easymotion/vim-easymotion')
-- File Tree
vim.fn['plug#']('preservim/nerdtree')
-- Better syntax highlighting
vim.fn['plug#']('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })

vim.call('plug#end')

-- General Stuff

-- Enable Syntax Highlighting
vim.cmd[[
    syntax = true
    colorscheme dracula
]]

-- Set all of the tab spacing settings to 2 spaces
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Fold method
vim.opt.foldmethod = "indent"

-- Use mouse
vim.opt.mouse = "a"

-- Show line numbers (hybrid)
vim.opt.number = true
vim.opt.relativenumber = true

-- turn off swap files
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

-- Custom keymaps

-- Move between split panes using the Alt key
vim.api.nvim_set_keymap('n', '<A-h>', '<C-w>h', { noremap = true })
vim.api.nvim_set_keymap('n', '<A-j>', '<C-w>j', { noremap = true })
vim.api.nvim_set_keymap('n', '<A-k>', '<C-w>k', { noremap = true })
vim.api.nvim_set_keymap('n', '<A-l>', '<C-w>l', { noremap = true })
-- Clear highlight
vim.api.nvim_set_keymap('n', '<C-h>', ':noh<Enter>', { noremap = true })
vim.api.nvim_set_keymap('n', '<S-h>', ':set wrap!<Enter>', { noremap = true })

-- Visual block indent; keep block
vim.cmd[[
    vmap < <gv
    vmap > >gv
]]

-- Macros
vim.cmd("let @t = 'i`wea`'")

-- Plugin Configuration

-- Vim Airline Theme Stuff
vim.g.airline_powerline_fonts = 1

-- Plugin configuration source files
require('coc-config')
require('treesitter-config')

-- Nerd Tree
-- Remaps
vim.api.nvim_set_keymap('n', '<leader>n', ':NERDTreeFocus<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-n>', ':NERDTree<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-t>', ':NERDTreeToggle<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-f>', ':NERDTreeFind<CR>', { noremap = true })

-- Config
-- Start NERDTree and put the cursor back in the other window.
vim.cmd("autocmd VimEnter * NERDTree | wincmd p")
-- Exit Vim if NERDTree is the only window remaining in the only tab.
vim.cmd("autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif")
