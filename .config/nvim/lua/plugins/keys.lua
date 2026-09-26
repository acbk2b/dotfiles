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
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
        -- use opts = {} for passing setup options
        -- this is equivalent to setup({}) function
    }
}
