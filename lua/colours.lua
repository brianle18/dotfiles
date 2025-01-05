---------------------------------------------
-- Colourscheme related configs
-- Default uses gruvbox-material
---------------------------------------------

local o = vim.o
local g = vim.g

-- This configuration option should be placed before `colorscheme gruvbox-material`.
-- Available values: 'hard', 'medium'(default), 'soft'
-- For better performance
o.background = "dark"
g.gruvbox_material_background = 'hard'
g.gruvbox_material_better_performance = 1
g.gruvbox_material_diagnostic_virtual_text = 'colored'
vim.cmd("colorscheme gruvbox-material")
-- For diagnostic lines
local keyset = vim.keymap.set
vim.diagnostic.config({ virtual_text = false })
keyset("n", "<leader>tl", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })
-- Airline themes

g.airline_theme = 'ayu_dark'

