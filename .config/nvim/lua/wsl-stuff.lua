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
]]

-- autocmd User CocStatusChange redraws
vim.api.nvim_create_autocmd("User", {
    pattern = "CocStatusChange",
    command = "redraws",
    -- desc = "Fix no statusbar update without keypress"
})
