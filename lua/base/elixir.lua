-- `on_attach` callback will be called after a language server
-- instance has been attached to an open buffer with matching filetype
-- here we're setting key mappings for hover documentation, goto definitions, goto references, etc
-- you may set those key mappings based on your own preference
local on_attach = function(client, bufnr)
  local opts = { noremap=true, silent=true }

  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>cr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>cf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>cd', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
end

-- setting up the elixir language server
-- you have to manually specify the entrypoint cmd for elixir-ls
local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('lspconfig').elixirls.setup {
  cmd = { "/Users/brianle/elixir/language_server.sh" },
  filetypes = { "elixir" },
  on_attach = on_attach,
  capabilities = capabilities
}
require('lspconfig').tsserver.setup {
  filetypes = { "typescript", "typescriptreact" },
  on_attach = on_attach,
  capabilities = capabilities
}
require('lspconfig').pyright.setup {
  filetypes = {"python"},
  on_attach = on_attach,
  capabilities = capabilities
}
-- -- Autocomplete stuff
-- local cmp = require'cmp'

-- cmp.setup({
--   snippet = {
--     expand = function(args)
--       -- setting up snippet engine
--       -- this is for vsnip, if you're using other
--       -- snippet engine, please refer to the `nvim-cmp` guide
--       vim.fn["vsnip#anonymous"](args.body)
--     end,
--   },
--   mapping = {
--     ['<CR>'] = cmp.mapping.confirm({ select = true }),
--   },
--   sources = cmp.config.sources({
--     { name = 'nvim_lsp' },
--     { name = 'vsnip' }, -- For vsnip users.
--     { name = 'buffer' }
--   })
-- })

-- -- -- vsnip
-- -- helper functions
-- local has_words_before = function()
--   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--   return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
-- end

-- local feedkey = function(key, mode)
--   vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
-- end

-- cmp.setup({
--   -- other settings ...
--   mapping = {
--     -- other mappings ...
--     ["<Tab>"] = cmp.mapping(function(fallback)
--       if cmp.visible() then
-- 	cmp.select_next_item()
--       elseif vim.fn["vsnip#available"](1) == 1 then
-- 	feedkey("<Plug>(vsnip-expand-or-jump)", "")
--       elseif has_words_before() then
-- 	cmp.complete()
--       else
-- 	fallback()
--       end
--     end, { "i", "s" }),
--     ["<S-Tab>"] = cmp.mapping(function()
--       if cmp.visible() then
-- 	cmp.select_prev_item()
--       elseif vim.fn["vsnip#jumpable"](-1) == 1 then
-- 	feedkey("<Plug>(vsnip-jump-prev)", "")
--       end
--     end, { "i", "s" })
--   }
-- })
