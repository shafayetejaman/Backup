-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.relativenumber = true
vim.opt.clipboard = ""
vim.opt.list = false

-- ~/.config/nvim/lua/config/lazy.lua
vim.api.nvim_set_hl(0, "MiniCursorword", {})
vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", {})
-- turn off cursor line highlight
vim.opt.cursorline = false
require("config.highlights")
vim.opt.shortmess:append("I") -- disables intro/startup messages
vim.cmd("silent! messages clear")
