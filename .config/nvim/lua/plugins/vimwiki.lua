return {
	"vimwiki/vimwiki",
	cmd = { "VimwikiIndex" },
	ft = { "vimwiki", "markdown" },
	init = function()
		vim.g.vimwiki_key_mappings = {
			table_mappings = 0,
		}
		vim.g.vimwiki_table_mappings = 0

		-- Set wiki locations + Markdown syntax
		vim.g.vimwiki_list = { {
			path = "~/notes",
			syntax = "markdown",
			ext = ".md",
			diary_rel_path = "daily-chaos/",
		} }
	end,
	config = function()
		local vimwiki_opts = vim.api.nvim_create_augroup("UserVimwikiLocalOptions", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter" }, {
			group = vimwiki_opts,
			pattern = { "*.md", "*.wiki" },
			callback = function()
				vim.opt_local.filetype = "vimwiki"
			end,
		})
	end,
}
