---------------------------------------------
-- Colourscheme related configs
-- Default uses gruvbox-material
---------------------------------------------

local o = vim.o
local g = vim.g

-- This configuration option should be placed before `colorscheme gruvbox-material`.
-- Available values: 'hard', 'medium'(default), 'soft'
-- For better performance
o.background = "dark"
g.gruvbox_material_background = "hard"
g.gruvbox_material_better_performance = 1
g.gruvbox_material_diagnostic_virtual_text = "colored"
vim.cmd("colorscheme gruvbox-material")

local lsp_failed = {}

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client then lsp_failed[client.name] = nil end
    end,
})

vim.api.nvim_create_autocmd("LspDetach", {
    callback = function(args)
        local name = (vim.lsp.get_client_by_id(args.data.client_id) or {}).name
        if not name then return end
        vim.defer_fn(function()
            for _, c in ipairs(vim.lsp.get_clients()) do
                if c.name == name then return end
            end
            lsp_failed[name] = true
            vim.cmd.redrawstatus()
        end, 500)
    end,
})

-- Airline themes
-- g.airline_theme = 'ayu_dark'
require("lualine").setup({
    options = { theme = "gruvbox-material" },
    sections = {
        lualine_a = { "mode" },
        lualine_b = {
            {
                "branch",
                fmt = function(name)
                    if #name <= 20 then return name end
                    return name:sub(1, 9) .. "..." .. name:sub(-8)
                end,
            },
            "diff",
            "diagnostics",
        },
        lualine_c = { "filename", require("lsp-status").status },
        lualine_x = {
            {
                function()
                    local ignored = { augment = true, copilot = true, ["GitHub Copilot"] = true, ["Augment Server"] = true }
                    local clients = vim.lsp.get_clients({ bufnr = 0 })
                    local names = {}
                    for _, c in ipairs(clients) do
                        if not ignored[c.name] then names[#names + 1] = c.name end
                    end
                    if #names == 0 then return "" end
                    return " " .. table.concat(names, " ")
                end,
                color = "String",
            },
            {
                function()
                    local ignored = { augment = true, copilot = true, ["GitHub Copilot"] = true, ["Augment Server"] = true }
                    local names = {}
                    for name in pairs(lsp_failed) do
                        if not ignored[name] then names[#names + 1] = name end
                    end
                    if #names == 0 then return "" end
                    return " " .. table.concat(names, " ")
                end,
                color = "DiagnosticError",
            },
            {
                function()
                    local lint = require('lint')
                    local configured = lint.linters_by_ft[vim.bo.filetype] or {}
                    local active = {}
                    for _, name in ipairs(configured) do
                        local l = lint.linters[name]
                        local cmd = l and (type(l.cmd) == 'function' and l.cmd() or l.cmd)
                        if cmd and vim.fn.executable(cmd) == 1 then
                            active[#active + 1] = name
                        end
                    end
                    if #active == 0 then return '' end
                    return ' ' .. table.concat(active, ' ')
                end,
                color = 'Type',
            },
            {
                function()
                    local lint = require('lint')
                    local configured = lint.linters_by_ft[vim.bo.filetype] or {}
                    local failed = {}
                    for _, name in ipairs(configured) do
                        local l = lint.linters[name]
                        local cmd = l and (type(l.cmd) == 'function' and l.cmd() or l.cmd)
                        if not cmd or vim.fn.executable(cmd) ~= 1 then
                            failed[#failed + 1] = name
                        end
                    end
                    if #failed == 0 then return '' end
                    return ' ' .. table.concat(failed, ' ')
                end,
                color = 'DiagnosticError',
            },
            {
                function()
                    local ok, conform = pcall(require, 'conform')
                    if not ok then return '' end
                    local active = {}
                    for _, f in ipairs(conform.list_formatters(0)) do
                        local skip = { injected = true, trim_whitespace = true }
                        if f.available and not skip[f.name] then active[#active + 1] = f.name end
                    end
                    if #active == 0 then return '' end
                    return ' ' .. table.concat(active, ' ')
                end,
                color = { fg = '#d3869b' },
            },
            {
                function()
                    local ok, conform = pcall(require, 'conform')
                    if not ok then return '' end
                    local failed = {}
                    for _, f in ipairs(conform.list_formatters(0)) do
                        local skip = { injected = true, trim_whitespace = true }
                        if not f.available and not skip[f.name] then failed[#failed + 1] = f.name end
                    end
                    if #failed == 0 then return '' end
                    return ' ' .. table.concat(failed, ' ')
                end,
                color = 'DiagnosticError',
            },
            "encoding", "fileformat", "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
    },
})
