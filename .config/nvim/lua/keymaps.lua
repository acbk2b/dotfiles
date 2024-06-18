-- Custom keymaps

local map = vim.keymap.set

-- Pane navigation
map('n', '<A-h>', '<C-w>h', { noremap = true })
map('n', '<A-j>', '<C-w>j', { noremap = true })
map('n', '<A-k>', '<C-w>k', { noremap = true })
map('n', '<A-l>', '<C-w>l', { noremap = true })

-- Pane split size
map('n', '<A-,>', '<C-w>>', { noremap = true })
map('n', '<A-.>', '<C-w><', { noremap = true })
map('n', '<A-->', '<C-w>-', { noremap = true })
map('n', '<A-=>', '<C-w>+', { noremap = true })

-- Clear highlight
map('n', '<C-h>', ':noh<Enter>', { noremap = true })
map('n', '<S-h>', ':set wrap!<Enter>', { noremap = true })

-- Visual block indent; keep block
map('v', '<', '<gv', { noremap = true })
map('v', '>', '>gv', { noremap = true })

-- Highlight the entire buffer in visual mode
map('n', 'vA', 'ggVG', { noremap = true })

-- wincpy script
-- Copy entire buffer
map('n', '<A-S-m>', ':%!wincpy<Enter>')
-- Copy selected visual range
map('v', '<A-S-m>', '!wincpy<Enter>')

-- Plugin Keymaps

-- lsp mappings
map('n', '<leader>dj', vim.diagnostic.goto_next, {buffer=0})
map('n', '<leader>dk', vim.diagnostic.goto_prev, {buffer=0})
map('n', '<leader>r', vim.lsp.buf.rename, {buffer=0})
map('n', '<leader>c', vim.lsp.buf.code_action, {buffer=0})

-- nvim-cmp
local cmp = require('cmp')
map('i', '<Tab>', cmp.select_next_item, {})
map('i', '<S-Tab>', cmp.select_prev_item, {})

-- coc-java
-- Organize Imports
map('n', '<A-S-o>', ':call CocAction(\'organizeImport\')<Enter>', { noremap = true })

-- NvimTree
map('n', '<C-t>', ':NvimTreeToggle<CR>')
