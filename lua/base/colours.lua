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
vim.cmd("colorscheme gruvbox-material")
-- o.termguicolors = true
-- g.gruvbox_flat_style = 'hard'
-- vim.cmd("colorscheme gruvbox-flat")

-- Airline themes

g.airline_theme = 'ayu_dark'
