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
--
-- For diagnostic lines
local keyset = vim.keymap.set
vim.diagnostic.config({ virtual_text = false })
keyset("n", "<leader>tl", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })

-- vim.cmd("colorscheme tokyonight-storm")
-- o.termguicolors = true
-- g.gruvbox_flat_style = 'hard'
-- vim.cmd("colorscheme gruvbox-flat")
-- vim.api.nvim_set_hl(0, "@text.note", {link = "@text.todo"})
-- require("todo-comments").setup{
--     signs= true,
--     highlight = {
--         before = "", -- "fg" or "bg" or empty
--         keyword = "wide", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
--         after = "fg" -- "fg" or "bg" or empty
--     },
--     keywords = {
--         BUG = "FIX",
--         FIX = "FIX",
--         FIXIT = "FIX",
--         FIXME = "FIX",
--         HACK = "HACK",
--         INFO = "NOTE",
--         ISSUE = "FIX",
--         NOTE = "NOTE",
--         OPTIM = "PERF",
--         OPTIMIZE = "PERF",
--         PERF = "PERF",
--         PERFORMANCE = "PERF",
--         TODO = "TODO",
--         WARN = "WARN",
--         WARNING = "WARN",
--         XXX = "WARN"
--       },
-- }

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

-- embedded language formatting
require("conform").setup({
  formatters_by_ft = {
    sql = { "sqlfluff" },
    ["*"] = { "injected" }, -- enables injected-lang formatting for all filetypes
  }
})


-- require("conform").formatters.sql_formatter = {
--   prepend_args = { "-c", vim.fn.expand("~/.config/sql_formatter.json"), }
-- }
