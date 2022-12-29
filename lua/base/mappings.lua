---------------------------------------------
-- Toggle keys
---------------------------------------------
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local expr_options = { noremap = true, expr = true, silent = true }


function toggleln()
  if vim.b.lnstatus == nil then
    vim.b.lnstatus = "number"
  end

  if vim.b.lnstatus == "number" then
    vim.o.number = false
    vim.o.relativenumber = false
    vim.b.lnstatus = "nonumber"
  else
    vim.o.number = true
    vim.o.relativenumber = true
    vim.b.lnstatus = "number"
  end
end

-- Use \l to toggle the relative line number display.
map("", "<leader>l", ':lua toggleln()<CR>', opts )

-- -- Use \m to toggle mouse
map("n", "<leader>m", ':exec &mouse!=""? "set mouse=" : "set mouse=nv"<CR>', opts)

-- Use \o to enable paste mode
map("n", "<leader>o", ":setlocal paste!<CR>", opts)

-- Map \c to clear the highlighting from hlsearch
map("n", "<leader>c", ":nohlsearch<CR>", opts)

-- Map \t to toggle Nvim-tree
map("n", "<leader>t", ":NvimTreeToggle<CR>", opts)

-- Map \u toggle undo-tree
map("n", "<leader>u", ":UndotreeToggle<CR>", opts)

-- Navigate between windows
map("n", "<C-j>", "<C-W>j", opts)
map("n", "<C-k>", "<C-W>k", opts)
map("n", "<C-h>", "<C-W>h", opts)
map("n", "<C-l>", "<C-W>l", opts)

