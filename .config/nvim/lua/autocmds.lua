-- Set Jenkinsfiles to groovy FileType
vim.api.nvim_create_autocmd({"BufEnter"}, {
    pattern = "Jenkinsfile*",
    command = "setfiletype groovy"
})

-- Turn on spell check for .md and .wiki files
vim.api.nvim_create_autocmd({"BufEnter"}, {
    pattern = "*.md,*.wiki",
    command = "set spell"
})
