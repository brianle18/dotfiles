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
o.smarttab = true

-- Reduce size of tabs from 8
o.shiftwidth = 4
o.softtabstop = 4

-- copy to clipboard
-- vim.cmd("set clipboard+=unnamedplus")

-- ALE for linting
-- disable LSP (handled by TS and COC)
-- Use autopep8
--
g.ale_disable_lsp = 1
g.ale_sign_column_always = 1
g.ale_virtualtext_cursor = 0 -- disable the virtualtext
g.ale_fixers = { python = { "autopep8" } }
g.ale_python_flake8_options = "--max-line-length=120"
-- old vim command cos idk how to do * FIXME
-- TODO replace all ale_fixers with conform
vim.cmd("let b:ale_fixers = { '*': ['remove_trailing_lines', 'trim_whitespace'], 'python': ['autopep8'], }")

-- Conform for formatting
require("conform").setup({
    log_level = vim.log.levels.DEBUG,
    formatters_by_ft = {
        lua = { "stylua" },
        sql = { "sqlfluff" },
        ["*"] = { "injected", "trim_whitespace", "remove_trailing_lines" }, -- enables injected-lang formatting for all filetypes
    },
    format_on_save = {
        -- I recommend these options. See :help conform.format for details.
        lsp_format = "fallback",
        timeout_ms = 10000,
    },
    quiet = true,
    formatters = {
        stylua = {
            command = "stylua",
            args = { "--indent-type", "Spaces", "--indent-width", "4", "-" },
        },
        sqlfluff = {
            command = "/opt/homebrew/Caskroom/miniforge/base/bin/sqlfluff",
            args = { "format", "-", "--dialect", "postgres" },
            require_cwd = false,
            inherit = false,
        },
    },
})
