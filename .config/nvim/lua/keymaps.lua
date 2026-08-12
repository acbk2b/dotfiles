-- Custom keymaps

local git = require("lib.git")
local map = vim.keymap.set

-- Use verymagic regex mode by default for search/replace ops
map("n", "/", "/\\v", { noremap = true, desc = "Search with very magic mode" })
map("n", "?", "?\\v", { noremap = true, desc = "Search backwards with very magic mode" })
map("c", "s/", "s/\\v", { noremap = true, desc = "Substitute with very magic mode" })

-- Pane navigation
map("n", "<C-h>", "<C-w>h", { noremap = true })
map("n", "<C-j>", "<C-w>j", { noremap = true })
map("n", "<C-k>", "<C-w>k", { noremap = true })
map("n", "<C-l>", "<C-w>l", { noremap = true })

-- Pane split size
map("n", "<C-,>", "<C-w>>", { noremap = true })
map("n", "<C-.>", "<C-w><", { noremap = true })
map("n", "<C-->", "<C-w>-", { noremap = true })
map("n", "<C-=>", "<C-w>+", { noremap = true })

-- Toggle netrw sidebar
map("n", "<C-t>", ":Lexplore<CR>", { desc = "Toggle netrw sidebar" })

-- Clear highlight
map("n", "<leader>h", ":noh<Enter>", { noremap = true })
-- Toggle line wrap
map("n", "<leader>w", ":set wrap!<Enter>", { noremap = true })

-- Visual block indent; keep block
map("v", "<", "<gv", { noremap = true })
map("v", ">", ">gv", { noremap = true })

-- Highlight the entire buffer in visual mode
map("n", "vA", "ggVG", { noremap = true })

-- Invert Capitalization of a word
map("n", "cA", "b~e", { noremap = true })

-- md2rich script
-- Copy entire buffer
map("n", "<leader>m", ":w !md2rich<Enter>")
-- Copy selected visual range
map("v", "<leader>m", ":w !md2rich<Enter>")

-- Plugin Keymaps

-- Auto correct
local abbreviations = {
	{ abbr = "fiels", exp = "files" },
	{ abbr = "fo", exp = "of" },
	{ abbr = "fro", exp = "for" },
	{ abbr = "hte", exp = "the" },
	{ abbr = "hwo", exp = "how" },
	{ abbr = "konw", exp = "know" },
	{ abbr = "oru", exp = "our" },
	{ abbr = "taht", exp = "that" },
	{ abbr = "teh", exp = "the" },
}

local function create_abbreviation(abbrev, expansion)
	vim.api.nvim_cmd({
		cmd = "iabbrev",
		args = { abbrev, expansion },
	}, {})
end

for _, pair in ipairs(abbreviations) do
	create_abbreviation(pair.abbr, pair.exp)
end

vim.api.nvim_create_user_command("GitUrl", function()
	local filepath = vim.fn.expand("%:p")
	if filepath == "" then
		print("No file open")
		return
	end

	local url = git.getFileUrl(filepath)
	if not url then return end

	vim.fn.setreg("+", url)
	print("Copied: " .. url)
end, { desc = "Copy Git url for the current file" })
