-- For diagnostic lines
local keyset = vim.keymap.set
vim.diagnostic.config({ virtual_text = false })
keyset("n", "<leader>tl", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })
