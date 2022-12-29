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


----------------
-- Appearance --
----------------
-- wo.rnu
