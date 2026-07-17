-- Lazy plugin configuration

-- Bootstrap Lazy if not installed
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

-- Load plugins + configuration
local plugins = {}
local plugCfg = { "colors", "keys", "lsp", "vimwiki" }
for _, plug in ipairs(plugCfg) do
	table.insert(plugins, require("plugins/" .. plug))
end

-- Add any options for Lazy here
local opts = {
	performance = {
		cache = {
			enabled = true,
		},
	},
}
require("lazy").setup(plugins, opts)
