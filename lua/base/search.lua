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
local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope.find_files, {})
vim.keymap.set('n', '<leader>fg', telescope.live_grep, {})
vim.keymap.set('n', '<leader>fb', telescope.buffers, {})
vim.keymap.set('n', '<leader>fh', telescope.help_tags, {})


-- Nvim-tree
-- disable netrw at the very start of your init.lua (strongly advised)
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- OR setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
      group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
