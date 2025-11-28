-- Nvim LSP configuration
-- Generic LSP bindings
local on_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true }

    vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>cf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>cd", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
end

-- setting up the elixir language server
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Installer for LSP servers
require("mason").setup()
-- require("mason-lspconfig").setup({
--     ensure_installed = {
--         "elixirls",
--         "ts_ls",
--         "pyright",
--         "ruff",
--         "html",
--         "eslint",
--         "lua_ls",
--         "tinymist",
--     },
-- })
vim.lsp.enable("copilot")

-- LSP configs
-- Elixir
-- you have to manually specify the entrypoint cmd for elixir-ls
vim.lsp.config("elixirls", {
    cmd = { "/Users/brianle/Downloads/elixir-ls-v0.24.1/language_server.sh" },
    settings = {
        elixirLS = {
            projectDir = "",
            dialzyzerEnabled = false,
            fetchDeps = false,
            mixEnv = "test",
            mixTarget = "",
        },
    },
    filetypes = { "elixir" },
    on_attach = on_attach,
    capabilities = capabilities,
})

-- Expert (replacing elixirls)
-- vim.lsp.config.lexical.setup({
--     cmd = { "/Users/brianle/Documents/leaf_be/.expert/apps/expert/burrito_out/expert_darwin_arm64" },
--     root_dir = function(fname)
--         return vim.lsp.config.util.root_pattern(".git")(fname) or vim.loop.cwd()
--     end,
--     filetypes = { "elixir", "eelixir", "heex", "surface" },
--     on_attach = on_attach,
--     capabilities = capabilities,
-- })
vim.lsp.enable("elixirls")

-- TypeScript
vim.lsp.config("ts_ls", {
    filetypes = { "typescript", "typescriptreact" },
    on_attach = on_attach,
    capabilities = capabilities,
})
vim.lsp.enable("ts_ls")

-- TypeScript
vim.lsp.config("biome", {
    filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    on_attach = on_attach,
    capabilities = capabilities,
})

-- TinyMist
vim.lsp.config("tinymist", {
    filetypes = { "typst" },
    on_attach = on_attach,
    capabilities = capabilities,
})
vim.lsp.enable("tinymist")

-- Python
-- vim.lsp.config("pyright", {
--     settings = {
--         cmd = { "/opt/homebrew/Caskroom/miniforge/base/envs/notebooks/bin/pyright-langserver", "--stdio" },
--         python = {
--             venvPath = ".",
--             venv = ".venv",
--         },
--     },
--     filetypes = { "python" },
--     on_attach = on_attach,
--     capabilities = capabilities,
-- })
-- vim.lsp.enable("pyright")
vim.lsp.config("basedpyright", {
    settings = {
        python = {
            venv = ".venv",
        },
    },
    filetypes = { "python" },
    on_attach = on_attach,
    capabilities = capabilities,
})
vim.lsp.enable("basedpyright")

vim.lsp.config("ruff", {
    settings = {
        cmd = { "/opt/homebrew/Caskroom/miniforge/base/envs/notebooks/bin/ruff", "server" },
    },
    filetypes = { "python" },
    on_attach = on_attach,
    capabilities = capabilities,
})
vim.lsp.enable("ruff")

-- Lua
vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
        },
    },
    capabilities = capabilities,
})
vim.lsp.enable("lua_ls")

-- HTML
vim.lsp.config("html", {
    capabilities = capabilities,
    on_attach = on_attach,
})
vim.lsp.enable("html")

-- SQL
vim.lsp.config("sqlls", {
    filetypes = { "sql" },
    settings = {
        adapter = "postgres",
    },
    capabilities = capabilities,
    on_attach = on_attach,
})
vim.lsp.enable("sqlls")

-- Vimscript
vim.lsp.config("vimls", {
    filetypes = { "vim" },
    capabilities = capabilities,
    on_attach = on_attach,
})
vim.lsp.enable("vimls")

-- Dockerfile
vim.lsp.config("dockerls", {
    filetypes = { "dockerfile" },
    capabilities = capabilities,
    on_attach = on_attach,
})
vim.lsp.enable("dockerls")

-- GraphQL
vim.lsp.config("graphql", {
    settings = {
        schema = "https://localhost:4003/graphql",
    },
    filetypes = { "graphql", "javascriptreact", "typescriptreact", "typescript" },
    capabilities = capabilities,
    on_attach = on_attach,
})
vim.lsp.enable("graphql")

-- GitHub Actions
vim.lsp.config("gh_actions_ls", {
    filetypes = { "yaml" },
    capabilities = capabilities,
    on_attach = on_attach,
})
vim.lsp.enable("gh_actions_ls")

-- local util = require("lspconfig.util")
-- local lspconfig = vim.lsp.config

-- require("lspconfig.configs").postgres_lsp = {
--     default_config = {
--         name = "postgres_lsp",
--         cmd = { "postgres_lsp" },
--         filetypes = { "sql" },
--         single_file_support = true,
--         root_dir = util.root_pattern("root-file.txt"),
--     },
-- }

-- lspconfig.postgres_lsp.setup({ force_setup = true })

-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = "sql",
--     callback = function()
--         vim.bo.omnifunc = "vim_dadbod_completion#omni"
--     end,
-- })
