-- Language specific configs
require('lspconfig').lua_ls.setup({
    settings = {
        Lua = {
            globals = { 'vim' }
        }
    }
})

local g = vim.g

g.pymode_python = 'python3'
g.pymode_virtualenv = 0
g.pymode_rope = 0
g.pymode_init = 0
g.pymode_lint = 0
g.pymode_options_max_line_length=120

g.tws_pattern = 'X'
g.tws_color_md = { ctermbg= 138, guibg= 'RosyBrown' }
g.tws_color_any = { ctermbg= 211, guibg= 'PaleVioletRed' }

-- require('lspconfig').elixirls.setup {
--   cmd = { "~/.local/share/nvim/lsp_servers/tsserver/node_modules/typescript/bin/tsc" },
--   filetypes = { "typescript", "typescriptreact" },
--   on_attach = on_attach,
--   capabilities = capabilities
-- }
