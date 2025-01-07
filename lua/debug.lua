-- For diagnostic lines
local keyset = vim.keymap.set
vim.diagnostic.config({ virtual_text = false })
keyset("n", "<leader>tl", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })

-- Notify
local notify = require("notify")
vim.lsp.handlers["window/showMessage"] = function(_, result, ctx)
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    local lvl = ({
        "ERROR",
        "WARN",
        "INFO",
        "DEBUG",
    })[result.type]
    notify({ result.message }, lvl, {
        title = "LSP | " .. client.name,
        timeout = 10000,
        keep = function()
            return lvl == "ERROR" or lvl == "WARN"
        end,
    })
end
