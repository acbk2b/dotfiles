-- NVim main config file

-- Configs
require('plugins/init')
require('autocmds')
require('keymaps')

-- Enable Syntax Highlighting/color scheme
vim.cmd('colorscheme dracula')

local options = {
    backup = false,
    expandtab = true,
    foldmethod = 'indent',
    mouse = 'a',
    number = true,
    relativenumber = true,
    shiftwidth = 4,
    softtabstop = 4,
    swapfile = false,
    tabstop = 4,
    writebackup = false,
}

for k, v in pairs(options) do
    vim.opt[k] = v
end
