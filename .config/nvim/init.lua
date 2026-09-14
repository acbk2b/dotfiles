-- NVim main config file

-- Configs

require("autocmds")
require("fmt")
require("keymaps")
require("plugin-loader")

local options = {
	clipboard = "unnamedplus",
	expandtab = true,
	foldmethod = "indent",
	mouse = "a",
	number = true,
	relativenumber = true,
	shiftwidth = 4,
	swapfile = false,
	tabstop = 4,
	winborder = "rounded", -- Borders on all floats (hover, signature, diagnostics)
	writebackup = false,
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

-- netrw
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 25
