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
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>cf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>cd", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
end

-- setting up the elixir language server
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Installer for LSP servers
require("mason").setup()

-- LSP configs

-- Elixir
-- you have to manually specify the entrypoint cmd for elixir-ls
require("lspconfig").elixirls.setup({
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

require("lspconfig").ts_ls.setup({
    filetypes = { "typescript", "typescriptreact" },
    on_attach = on_attach,
    capabilities = capabilities,
})

require("lspconfig").pyright.setup({
    filetypes = { "python" },
    on_attach = on_attach,
    capabilities = capabilities,
})

require("lspconfig").lua_ls.setup({
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
        },
    },
    capabilities = capabilities,
})
