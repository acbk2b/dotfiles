-- Custom keymaps

local map = vim.keymap.set

-- Use verymagic regex mode by default for search/replace ops
map("n", "/", "/\\v", { desc = "Search with very magic mode" })
map("n", "?", "?\\v", { desc = "Search backwards with very magic mode" })
map("c", "s/", "s/\\v", { desc = "Substitute with very magic mode" })

-- Pane navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Pane split size
map("n", "<C-,>", "<C-w>>")
map("n", "<C-.>", "<C-w><")
map("n", "<C-->", "<C-w>-")
map("n", "<C-=>", "<C-w>+")

-- Toggle netrw sidebar
map("n", "<C-t>", ":Lexplore<CR>", { desc = "Toggle netrw sidebar" })

-- Open the netrw entry under the cursor in a split. When used from the
-- :Lexplore sidebar, split the editing window instead of the sidebar.
local function netrw_open_split(split_cmd)
	local word = vim.fn["netrw#Call"]("NetrwGetWord")
	if word == "" or word == "../" or word == "./" then
		return
	end

	local path = vim.fn["netrw#Call"]("NetrwTreeDir", 1) .. word

	if vim.t.netrw_lexbufnr == vim.api.nvim_get_current_buf() then
		local target = vim.fn.win_getid(vim.g.netrw_chgwin or -1)
		if target ~= 0 then
			vim.api.nvim_set_current_win(target)
		end
	end

	vim.cmd(split_cmd .. " " .. vim.fn.fnameescape(path))
end

-- netrw sets buffer-local maps that override globals, so set ours per buffer
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("UserNetrwKeymaps", { clear = true }),
	pattern = "netrw",
	callback = function(args)
		local function bmap(lhs, rhs, desc, opts)
			map("n", lhs, rhs, vim.tbl_extend("force", { buffer = args.buf, nowait = true, desc = desc }, opts or {}))
		end

		-- netrw binds <C-l> (refresh) and <C-h> (hide edit) unless their <Plug>
		-- targets are already mapped, so move them to other keys first
		bmap("<leader>r", "<Plug>NetrwRefresh", "netrw: refresh", { remap = true })
		bmap("<leader>nh", "<Plug>NetrwHideEdit", "netrw: edit hide list", { remap = true })

		-- Restore pane navigation
		bmap("<C-h>", "<C-w>h", "Go to left pane")
		bmap("<C-l>", "<C-w>l", "Go to right pane")

		-- Splits (matches fzf.vim)
		bmap("<C-v>", function() netrw_open_split("vsplit") end, "netrw: open in vertical split")
		bmap("<C-x>", function() netrw_open_split("split") end, "netrw: open in horizontal split")
	end,
})

-- Clear highlight
map("n", "<leader>h", ":noh<Enter>")
-- Toggle line wrap
map("n", "<leader>w", ":set wrap!<Enter>")

-- Visual block indent; keep block
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Highlight the entire buffer in visual mode
map("n", "vA", "ggVG")

-- Invert Capitalization of a word
map("n", "cA", "b~e")

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

	local url = require("lib.git").getFileUrl(filepath)
	if not url then return end

	vim.fn.setreg("+", url)
	print("Copied: " .. url)
end, { desc = "Copy Git url for the current file" })
