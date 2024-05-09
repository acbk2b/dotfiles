-- File type overrides

-- Set Jenkinsfiles to groovy FileType
vim.api.nvim_create_autocmd({"BufEnter"}, {
    pattern = "Jenkinsfile*",
    command = "setfiletype groovy"
})

-- Set *MCOM to csv FileType
vim.api.nvim_create_autocmd({"BufEnter"}, {
    pattern = "*.MCOM",
    command = "setfiletype csv"
})


-- Turn on spell check for .md and .wiki files
vim.api.nvim_create_autocmd({"BufEnter"}, {
    pattern = "*.md,*.wiki",
    command = "set spell"
})
