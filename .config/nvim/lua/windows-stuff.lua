-- Windows Stuff
-- Clipboard yank
vim.cmd[[
    " WSL yank support
    let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
    if executable(s:clip)
        augroup WSLYank
            autocmd!
            autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
        augroup END
    endif
    "TODO: Coc Extensions
    let g:coc_global_extensions = [
    \'coc-java',
    \'coc-pyright',
    \'coc-tsserver'
    \]
]]

vim.g['coc_global_extensions'] = {'coc-go', 'coc-java', 'coc-json', 'coc-pairs', 'coc-pyright', 'coc-tsserver'}
-- autocmd User CocStatusChange redraws
vim.api.nvim_create_autocmd("User", {
    pattern = "CocStatusChange",
    command = "redraws",
    desc = "Fix no statusbar update without keypress"
})