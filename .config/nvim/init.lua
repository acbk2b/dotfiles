-- NVim main config file

-- Configs

require("autocmds")
require("fmt")
require("keymaps")
require("plugins/init")

-- Enable Syntax Highlighting/color scheme
vim.cmd("colorscheme dracula")

local options = {
    autocomplete = true,
	backup = false,
	clipboard = "unnamedplus",
    completeopt = { 'menu', 'menuone', 'noselect' },
	expandtab = true,
	foldmethod = "indent",
	mouse = "a",
	number = true,
	relativenumber = true,
	shiftwidth = 4,
	swapfile = false,
	tabstop = 4,
	writebackup = false,
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

-- netrw
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 25

-- WSL
if vim.fn.has("wsl") == 1 then
	require("nvim-treesitter.install").prefer_git = true
end
