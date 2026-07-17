-- File type overrides

local filetype_overrides = vim.api.nvim_create_augroup("UserFiletypeOverrides", { clear = true })
local filetype_local_opts = vim.api.nvim_create_augroup("UserFiletypeLocalOptions", { clear = true })

-- Set Jenkinsfiles to groovy FileType
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	group = filetype_overrides,
	pattern = "Jenkinsfile*",
	callback = function()
		vim.bo.filetype = "groovy"
	end,
})

-- Set Terraform files to terraform FileType
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	group = filetype_overrides,
	pattern = {"*.tfvars"},
	callback = function()
		vim.bo.filetype = "terraform"
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = filetype_local_opts,
	pattern = { "tex" },
	callback = function()
		local options = {
			spell = true,
			foldmethod = "manual",
		}

		for k, v in pairs(options) do
			vim.opt_local[k] = v
		end
	end,
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
	group = filetype_local_opts,
	pattern = { "*.md", "*.wiki" },
	callback = function()
		local options = {
			expandtab = true,
			shiftwidth = 2,
			softtabstop = 2,
			spell = true,
			tabstop = 2,
		}
		for k, v in pairs(options) do
			vim.opt_local[k] = v
		end
	end,
})

-- Set specific file options via autocmd
vim.api.nvim_create_autocmd("FileType", {
	group = filetype_local_opts,
	pattern = { "java", "typescript" },
	callback = function()
		local options = {
			expandtab = true,
			shiftwidth = 2,
			softtabstop = 2,
			tabstop = 2,
		}

		for k, v in pairs(options) do
			vim.opt_local[k] = v
		end
	end,
})
