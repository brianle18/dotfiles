---------------------------------------------
-- FORMATTING
---------------------------------------------

local o = vim.o

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

-- Conform for formatting
require("conform").setup({
    log_level = vim.log.levels.DEBUG,
    formatters_by_ft = {
        lua = { "stylua" },
        sql = { "sqlfluff" },
        json = { "jq" },
        elixir = { "mix" },
        python = { "ruff_format" },
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
            args = { "format", "-", "--dialect", "postgres", "--ignore", "templating" },
            require_cwd = false,
            inherit = false,
        },
        mix = {
            command = "mix",
            args = { "format", "-" },
            cwd = require("conform.util").root_file({ ".envrc" }),
        },
    },
})
