-- NVim lua config file

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
-- Markdown
vim.fn['plug#']('godlygeek/tabular')
vim.fn['plug#']('preservim/vim-markdown')
-- Nerd Tree
vim.fn['plug#']('preservim/nerdtree')
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

-- General Stuff

-- Enable Syntax Highlighting/color scheme
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

-- Set Jenkinsfiles to groovy FileType
vim.api.nvim_create_autocmd({"BufRead" ,"BufNewFile"}, {
    pattern = "Jenkinsfile*",
    command = "setfiletype groovy"
})

-- Plugin Configuration

-- Vim Airline Theme Stuff
vim.g.airline_powerline_fonts = 1

-- Plugin configuration source files
require('coc-config')
require('treesitter-config')
-- Load WSL config if running on WSL
if vim.fn.has('wsl') == 1 then
    require('wsl-stuff')
end

-- Nerd Tree
-- Remaps
vim.api.nvim_set_keymap('n', '<leader>n', ':NERDTreeFocus<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-n>', ':NERDTree<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-t>', ':NERDTreeToggle<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-f>', ':NERDTreeFind<CR>', { noremap = true })

-- VimWiki
-- Fix coc/VimWiki conflict on Tab/S-Tab key
vim.api.nvim_create_autocmd("FileType", {
    pattern = "vimwiki",
    callback = function()
        -- Unmap for current buffer, in insert mode, Tab and S-Tab keys
        vim.api.nvim_buf_del_keymap(0, 'i', '<Tab>')
        vim.api.nvim_buf_del_keymap(0, 'i', '<S-Tab>')
    end
})

-- Config
-- Start NERDTree and put the cursor back in the other window.
-- vim.cmd("autocmd VimEnter * NERDTree | wincmd p")
vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*",
    callback = function ()
        -- TODO
        vim.cmd("NERDTree | wincmd p")
    end
})
-- Exit Vim if NERDTree is the only window remaining in the only tab.
-- vim.cmd("autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif")
vim.api.nvim_create_autocmd("BufEnter" , {
    pattern = "*",
    callback = function ()
        vim.cmd("if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif")
    end
})
