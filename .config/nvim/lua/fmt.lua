local lspFmt = function()
    vim.lsp.buf.format({ async = false })
end

-- Runs shell formatter + captures stdout
local function shellFmt(cmd)
    return function()
        -- Read current buffer content
        local buf = vim.api.nvim_get_current_buf()
        local input = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

        -- Pipe buffer content via stdin to formatter -> capture stdout
        local output = vim.fn.systemlist(vim.deepcopy(cmd), input)
        -- Verify shell successf -> don't write error junk to buffer
        if vim.v.shell_error == 0 and #output > 0 then
            -- Write formatter stdout to current buffer (entire file)
            vim.api.nvim_buf_set_lines(buf, 0, -1, false, output)
        end
    end
end

local fmt = {
    { pattern = "*.go",   callback = lspFmt },
    { pattern = "*.java", callback = shellFmt({ "google-java-format", "-" }) },
    { pattern = "*.json", callback = shellFmt({ "jq", "." }) },
    { pattern = "*.lua",  callback = lspFmt },
    { pattern = "*.md",   callback = shellFmt({ "prettier", "--parser", "markdown" }) },
    { pattern = "*.py",   callback = shellFmt({ "black", "-q", "-" }) },
    { pattern = "*.rego", callback = shellFmt({ "opa", "fmt" })},
    { pattern = "*.rs",   callback = lspFmt },
    { pattern = "*.tf",   callback = shellFmt({ "terraform", "fmt", "-" }) },
    { pattern = "*.yml",  callback = shellFmt({ "prettier", "--parser", "yaml" }) },
}

for _, formatter in ipairs(fmt) do
    vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = formatter.pattern,
        callback = formatter.callback,
    })
end
