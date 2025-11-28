-- TODO move me to copilot.lua
vim.keymap.set(
    "i",
    "<C-J>",
    'copilot#Accept("\\<CR>")',
    { expr = true, replace_keycodes = false, desc = "Accept copilot completion" }
)
vim.g.copilot_no_tab_map = true

require("avante").setup({
    -----@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
    --provider = "openai", -- The provider used in Aider mode or in the planning phase of Cursor Planning Mode
    -- WARNING: Since auto-suggestions are a high-frequency operation and therefore expensive,
    -- currently designating it as `copilot` provider is dangerous because: https://github.com/yetone/avante.nvim/issues/1048
    -- Of course, you can reduce the request frequency by increasing `suggestion.debounce`.
    auto_suggestions_provider = "copilot",
    mode = "agentic",
    provider = "azure",
    behaviour = {
        auto_set_highlight_group = true,
    },
    providers = {
        azure = {
            endpoint = "https://leaf.openai.azure.com/openai/deployments/gpt-4/chat/completions?api-version=2024-08-01-preview",
            model = "gpt-4o",
            extra_request_body = {
                temperature = 0,
            },
        },
        openai = {
            endpoint = "https://api.openai.com/v1",
            model = "gpt-4o-mini-2024-07-18",
            extra_request_body = {
                -- timeout = 30000,
                temperature = 0,
            },
        },
    },
    highlights = {
        diff = {
            current = "DiffText",
            incoming = "DiffAdd",
        },
    },
    system_prompt = function()
        local hub = require("mcphub").get_hub_instance()
        return hub and hub:get_active_servers_prompt() or ""
    end,
    -- Using function prevents requiring mcphub before it's loaded
    custom_tools = function()
        return {
            require("mcphub.extensions.avante").mcp_tool(),
        }
    end,
})
vim.api.nvim_set_hl(0, "AvanteConflictCurrent", { bg = "#562C30", default = true, bold = true })
