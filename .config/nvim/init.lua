-- NVim lua config file

-- Configs
require('plugins/init')
require('remaps')

-- General Stuff
-- Enable Syntax Highlighting/color scheme
vim.cmd('colorscheme dracula')

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

-- Set Jenkinsfiles to groovy FileType
vim.api.nvim_create_autocmd({"BufRead" ,"BufNewFile"}, {
    pattern = "Jenkinsfile*",
    command = "setfiletype groovy"
})

-- Turn on spell check for .md and .wiki files
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = "*.md,*.wiki",
    command = "set spell!"
})
