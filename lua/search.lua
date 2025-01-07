---------------------------------------------
-- Search functionality
---------------------------------------------

local o = vim.o
local g = vim.g

-- Highlight text as you type when searching for text
o.incsearch = true

-- Make searches case-insensitive
o.ignorecase = true

-- Make searches case-sensitive if you use capital letters
o.smartcase = true

-- hl search highlights the current search
o.hlsearch = true

g.nvim_tree_respect_buf_cwd = 1

-- Telescope mappings
local telescope = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", telescope.find_files, {})
vim.keymap.set("n", "<leader>fg", telescope.live_grep, {})
vim.keymap.set("n", "<leader>fw", telescope.grep_string, {})
vim.keymap.set("n", "<leader>fb", telescope.buffers, {})
vim.keymap.set("n", "<leader>fh", telescope.help_tags, {})
vim.keymap.set("n", "<leader>fc", telescope.commands, {})
vim.keymap.set("n", "<leader>fr", telescope.lsp_definitions, {})
vim.keymap.set("n", "<leader>fr", telescope.lsp_references, {})

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

-- Nvim-tree
-- disable netrw at the very start of your init.lua (strongly advised)
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- OR setup with some options
require("nvim-tree").setup({
    sort_by = "case_sensitive",
    view = {
        adaptive_size = true,
        -- mappings = {
        --   list = {
        --     { key = "u", action = "dir_up" },
        --   },
        -- },
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = true,
    },
})

-- OIL
require("oil").setup()
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
