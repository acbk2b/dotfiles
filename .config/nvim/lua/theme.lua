local config_root = vim.fn.fnamemodify(vim.fn.stdpath("config"), ":h")
local path = config_root .. "/themes/current/neovim.lua"

local ok, theme = pcall(dofile, path)

if not ok then
    error("Failed to load Neovim theme: " .. theme)
end

return theme
