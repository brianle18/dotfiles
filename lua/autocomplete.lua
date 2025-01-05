-- require('tabnine').setup({
--   disable_auto_comment=true,
--   accept_keymap="<Tab>",
--   dismiss_keymap = "<C-]>",
--   debounce_ms = 800,
--   suggestion_color = {gui = "#808080", cterm = 244},
--   exclude_filetypes = {"TelescopePrompt"},
--   log_file_path = nil, -- absolute path to Tabnine log file
-- })

vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })
vim.g.copilot_no_tab_map = true
-- require("copilot").setup()
-- support@psychhelp.com.au
--
vim.g.vim_textobj_elixir_mapping = 'e'
