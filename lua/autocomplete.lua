-- TODO move me to copilot.lua
vim.keymap.set(
    "i",
    "<C-J>",
    'copilot#Accept("\\<CR>")',
    { expr = true, replace_keycodes = false, desc = "Accept copilot completion" }
)
vim.g.copilot_no_tab_map = true
