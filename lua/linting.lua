-- Linting only
local linter = require("lint")
linter.linters_by_ft = {
  javascript = { "biomejs" },
  typescript = { "biomejs" },
  python = { "mypy", "ruff" },
  sql = { "sqlfluff" },
}

-- FIXME Need to fix
-- linter.linters.sqlfluff = {
--     cmd = "sqlfluff",
--     args = {
--         -- "lint",
--         -- "--format=json",
--         -- "--dialect=postgres",
--         "--ignore=templating",
--     },
-- }

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  group = lint_augroup,
  callback = function()
    linter.try_lint()
  end,
})

vim.keymap.set("n", "<leader>lf", function()
  linter.try_lint()
end, { desc = "Trigger linting for current file" })
