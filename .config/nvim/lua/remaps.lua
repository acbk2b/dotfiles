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

-- Plugin Keymaps

-- coc-java
-- Organize Imports
map('n', '<A-S-o>', ':call CocAction(\'organizeImport\')<Enter>', { noremap = true })

-- NvimTree
map('n', '<C-t>', ':NvimTreeToggle<CR>')
