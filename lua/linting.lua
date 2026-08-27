-- Linting only
local linter = require("lint")

-- Prefer the Biome installed by the project that owns the current buffer.
-- Neovim's cwd can be unrelated when opening files from a picker or another
-- project, so resolving `./node_modules/.bin/biome` from cwd is unreliable.
local function biome_command()
    local filename = vim.api.nvim_buf_get_name(0)
    local start = filename ~= "" and filename or vim.uv.cwd()
    local local_biome = vim.fs.find({ "node_modules/.bin/biome" }, {
        path = start,
        upward = true,
        type = "file",
        limit = 1,
    })[1]

    return local_biome or "biome"
end

-- Biome resolves biome.json from its working directory. Use the nearest
-- project config (or local node_modules directory) instead of Neovim's cwd.
local function biome_cwd()
    local filename = vim.api.nvim_buf_get_name(0)
    local start = filename ~= "" and filename or vim.uv.cwd()
    local config = vim.fs.find({ "biome.json", "biome.jsonc", ".biome.json", ".biome.jsonc" }, {
        path = start,
        upward = true,
        type = "file",
        limit = 1,
    })[1]
    if config then
        return vim.fs.dirname(config)
    end

    local local_biome = biome_command()
    if local_biome ~= "biome" then
        return vim.fs.dirname(vim.fs.dirname(vim.fs.dirname(local_biome)))
    end

    return vim.fs.root(start, { "package.json", ".git" }) or vim.fn.getcwd()
end

linter.linters_by_ft = {
    javascript = { "biomejs" },
    typescript = { "biomejs" },
    json = { "biomejs" },
    jsonc = { "biomejs" },
    python = { "mypy", "ruff" },
    -- sql = { "sqlfluff" },
    env = { "dotenv_linter" },
}

linter.linters.biomejs.cmd = biome_command
linter.linters.biomejs.parser = function(output)
    local diagnostics = {}
    local pending

    for line in vim.gsplit(output, "\n", { plain = true }) do
        local lnum, col, code = line:match("^[^:]+:(%d+):(%d+)%s+([^%s]+)")
        if lnum then
            pending = { lnum = lnum, col = col, code = code }
        elseif pending then
            local marker, message = line:match("^%s*([×!])%s*(.+)$")
            if marker then
                table.insert(diagnostics, {
                    source = "biomejs",
                    lnum = tonumber(pending.lnum) - 1,
                    col = tonumber(pending.col) - 1,
                    code = pending.code,
                    message = message,
                    severity = marker == "!" and vim.diagnostic.severity.WARN or vim.diagnostic.severity.ERROR,
                })
                pending = nil
            end
        end
    end

    return diagnostics
end

linter.linters.mypy.cmd = "mypy"
linter.linters.sqlfluff.cmd = "sqlfluff"
linter.linters.sqlfluff.args = {
    "lint",
    "--format=json",
    "--dialect=snowflake",
    "--ignore=templating",
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

local biome_filetypes = {
    javascript = true,
    typescript = true,
    json = true,
    jsonc = true,
}

local function lint_current_buffer()
    if biome_filetypes[vim.bo.filetype] then
        linter.try_lint("biomejs", { cwd = biome_cwd() })
    else
        linter.try_lint()
    end
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    group = lint_augroup,
    callback = function()
        lint_current_buffer()
    end,
})

vim.keymap.set("n", "<leader>lf", function()
    lint_current_buffer()
end, { desc = "Trigger linting for current file" })
