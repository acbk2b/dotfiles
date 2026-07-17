return {
	-- Fuzzy file/buffer/grep finder
	{
		"junegunn/fzf.vim",
		dependencies = { "junegunn/fzf" },
		cmd = { "Files", "Buffers", "Rg", "Ag", "Lines", "BLines", "Commits", "BCommits" },
        -- Set keybinding in keys -> `config` func _not_ run before plugin load
		keys = {
			{ "<leader>f", "<cmd>Files<cr>", desc = "Find files (fzf)" },
		},
	},
	-- Vim-style navigation with tmux
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
			"TmuxNavigatorProcessList",
		},
		keys = {
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
			{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		},
	},
	-- Code comment shortcuts
	{ "tpope/vim-commentary", cmd = { "Commentary", "CommentaryLine" } },
	-- Change enclosing characters
	{
		"tpope/vim-surround",
		keys = {
			{ "ys", desc = "Add surrounding" },
			{ "cs", desc = "Change surrounding" },
			{ "ds", desc = "Delete surrounding" },
			{ "S", mode = "v", desc = "Add surrounding in visual mode" },
		},
	},
}
