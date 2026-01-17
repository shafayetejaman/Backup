-- Completion popup colors


-- Popup menu background
vim.api.nvim_set_hl(0, "Pmenu", { bg = "#ffffff", fg = "#000000" })                 -- non-selected
vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#81a1c1", fg = "#000000", bold = true }) -- selected

-- nvim-cmp items
vim.api.nvim_set_hl(0, "CmpItemAbbr", { fg = "#000000" })                             -- normal text
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#0000ff", bold = true })           -- matched letters
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#0000ff" })
vim.api.nvim_set_hl(0, "CmpItemKind", { fg = "#5e81ac" })                             -- icon color
vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#4c566a" })                             -- source text
vim.api.nvim_set_hl(0, "CmpItemSel", { fg = "#000000", bg = "#81a1c1", bold = true }) -- selected
