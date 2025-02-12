---------------------------------------------
-- Search functionality
---------------------------------------------

-- Basic functionality
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
vim.keymap.set("n", "<leader>ff", telescope.find_files, { desc = "Find files (Telescope)" })
vim.keymap.set(
    "n",
    "<leader>fg",
    require("telescope_multigrep"),
    { desc = "Grep in files (double space for file regex)(Telescope)" }
)
vim.keymap.set("n", "<leader>fw", telescope.grep_string, { desc = "Grep current word (Telescope)" })
vim.keymap.set("n", "<leader>fb", telescope.buffers, { desc = "Find buffers (Telescope)" })
vim.keymap.set("n", "<leader>fh", telescope.help_tags, { desc = "Find help tags (Telescope)" })
vim.keymap.set("n", "<leader>fc", telescope.commands, { desc = "Find commands (Telescope)" })
vim.keymap.set("n", "<leader>fd", telescope.lsp_definitions, { desc = "Find definitions (Telescope)" })
vim.keymap.set("n", "<leader>fr", telescope.lsp_references, { desc = "Find references (Telescope)" })
vim.keymap.set("n", "<leader>fk", telescope.keymaps, { desc = "Find keymaps (Telescope)" })
vim.keymap.set("n", "<leader>fn", "<cmd>Telescope notify<CR>", { desc = "Find notifications (Telescope)" })
vim.keymap.set("n", "<leader>fa", "<cmd>lua vim.lsp.buf.code_action()<CR>", { desc = "Find code actions" })
-- code actions
require("telescope").setup({
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_dropdown({
                -- even more opts
            }),
        },
    },
})
-- To get ui-select loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require("telescope").load_extension("ui-select")

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
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory with OIL" })
