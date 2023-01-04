---------------------------------------------
-- FORMATTING
---------------------------------------------

local o = vim.o
local g = vim.g
local wo = vim.wo

-------------------------------------
-- Indentation and code formatting --
-------------------------------------
-- Copies indent from previous line
o.autoindent = true

-- wrap long lines
o.wrap = true

-- adds a tab after certain characters (like {....)
o.smartindent = true

-- When pressing the tab key, uses multiple spaces
o.expandtab = true
o.smarttab  = true

-- Reduce size of tabs from 8
o.shiftwidth=4
o.softtabstop=4

-- ALE for linting
-- disable LSP (handled by TS and COC)
-- Use autopep8
g.ale_disable_lsp = 1
g.ale_sign_column_always = 1
g.ale_virtualtext_cursor = 0 -- disable the virtualtext
g.ale_fixers = {python = { 'autopep8' }}
-- old vim command cos idk how to do * FIXME
vim.cmd("let b:ale_fixers = { '*': ['remove_trailing_lines', 'trim_whitespace'], 'python': ['autopep8'], }")
