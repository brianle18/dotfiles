-- require("cmp").setup.{
--   sources = {
--     { name = "nvim_lsp" },
--     { name = "buffer" },
--   },
-- })
-- -- Setup up vim-dadbod
-- cmp.setup.filetype({ "sql" }, {
--   sources = {
--     { name = "vim-dadbod-completion" },
--     { name = "buffer" },
--   },
-- })
vim.diagnostic.config({
    virtual_text = false,
})
