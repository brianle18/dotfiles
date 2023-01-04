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

---- Colours for CSS'
---- -- Attaches to every FileType mode
--require 'colorizer'.setup()

---- Attach to certain Filetypes, add special configuration for `html`
---- Use `background` for everything else.
--require 'colorizer'.setup {
  --'css';
  --'javascript';
  --html = {
    --mode = 'foreground';
  --}
--}

---- Use the `default_options` as the second parameter, which uses
---- `foreground` for every mode. This is the inverse of the previous
---- setup configuration.
--require 'colorizer'.setup({
  --'css';
  --'javascript';
  --html = { mode = 'background' };
--}, { mode = 'foreground' })

---- Use the `default_options` as the second parameter, which uses
---- `foreground` for every mode. This is the inverse of the previous
---- setup configuration.
--require 'colorizer'.setup {
  --'*'; -- Highlight all files, but customize some others.
  --css = { rgb_fn = true; }; -- Enable parsing rgb(...) functions in css.
  --html = { names = false; } -- Disable parsing "names" like Blue or Gray
--}

---- Exclude some filetypes from highlighting by using `!`
--require 'colorizer'.setup {
  --'*'; -- Highlight all files, but customize some others.
  --'!vim'; -- Exclude vim from highlighting.
  ---- Exclusion Only makes sense if '*' is specified!
--}
