-- File type overrides

local filetype_overrides = vim.api.nvim_create_augroup("UserFiletypeOverrides", { clear = true })
local filetype_local_opts = vim.api.nvim_create_augroup("UserFiletypeLocalOptions", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	group = filetype_local_opts,
	pattern = "rego",
	callback = function()
		vim.bo.commentstring = "# %s"
	end,
})

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

local function markdown_list_prefix()
	local line = vim.api.nvim_get_current_line()

	if line:match("^%s*%- %[[ xX]%]") then
		return "- [ ] "
	end

	if line:match("^%s*%- ") then
		return "- "
	end

	return ""
end

local function markdown_enter()
	local line = vim.api.nvim_get_current_line()
	local indent = line:match("^(%s*)%- %[[ xX]%]%s*$") or line:match("^(%s*)%-%s*$")

    -- indent == true for "" and "  "
	if indent then
        -- Fire <C-u< for empty indent and <C-o><< for non-empty indent
		return indent == "" and "<C-u>" or "<C-o><<"
	end

	return "<CR>" .. markdown_list_prefix()
end

vim.api.nvim_create_autocmd("FileType", {
	group = filetype_local_opts,
	pattern = "markdown",
	callback = function(args)
		local options = {
			conceallevel = 2,
			expandtab = true,
			shiftwidth = 2,
			softtabstop = 2,
			spell = true,
			tabstop = 2,
		}
		for k, v in pairs(options) do
			vim.opt_local[k] = v
		end
		vim.keymap.set("i", "<CR>", markdown_enter, {
			buffer = args.buf,
			expr = true,
			desc = "Continue Markdown list",
		})
		vim.keymap.set("n", "o", function()
			return "o" .. markdown_list_prefix()
		end, {
			buffer = args.buf,
			expr = true,
			desc = "Continue Markdown list below",
		})
		vim.keymap.set("n", "O", function()
			return "O" .. markdown_list_prefix()
		end, {
			buffer = args.buf,
			expr = true,
			desc = "Continue Markdown list above",
		})
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
