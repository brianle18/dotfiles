-- TODO move me to copilot.lua
vim.keymap.set(
    "i",
    "<C-J>",
    'copilot#Accept("\\<CR>")',
    { expr = true, replace_keycodes = false, desc = "Accept copilot completion" }
)
vim.g.copilot_no_tab_map = true

require("avante").setup({
    ---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
    provider = "openai", -- The provider used in Aider mode or in the planning phase of Cursor Planning Mode
    -- WARNING: Since auto-suggestions are a high-frequency operation and therefore expensive,
    -- currently designating it as `copilot` provider is dangerous because: https://github.com/yetone/avante.nvim/issues/1048
    -- Of course, you can reduce the request frequency by increasing `suggestion.debounce`.
    auto_suggestions_provider = "copilot",
    openai = {
        endpoint = "https://api.openai.com/v1",
        model = "gpt-4o-mini-2024-07-18",
        timeout = 30000,
        temperature = 0,
        max_tokens = 4096,
    },
    highlights = {
        ---@type AvanteConflictHighlights
        diff = {
            current = "DiffText",
            incoming = "DiffAdd",
        },
    },
})
