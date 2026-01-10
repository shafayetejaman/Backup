-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
local opts = { desc = "Custom clipboard mapping", silent = true }

-- Yank to system clipboard
-- Normal and visual modes
map({ "n" }, "Y", '"+yy', opts)
map({ "v" }, "Y", '"+y', opts)

-- Paste from system clipboard
-- Normal and visual modes
map({ "n", "v" }, "<leader>p", '"+p', opts)
