-- VimWiki
-- Set alternate wiki to zettelkasten with Markdown syntax
vim.cmd[[
    let g:vimwiki_list = [{'path': '~/.local/share/nvim/zettelkasten/', 'syntax': 'markdown', 'ext': '.md'}]
    call vimwiki#vars#init()
]]
-- Fix coc/VimWiki conflict on Tab/S-Tab key
vim.api.nvim_create_autocmd("FileType", {
    pattern = "vimwiki",
    callback = function()
        -- Unmap for current buffer, in insert mode, Tab and S-Tab keys
        vim.api.nvim_buf_del_keymap(0, 'i', '<Tab>')
        vim.api.nvim_buf_del_keymap(0, 'i', '<S-Tab>')
        vim.api.nvim_buf_del_keymap(0, 'i', '<Enter>')
    end
})
