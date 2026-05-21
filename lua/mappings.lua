---------------------------------------------
-- Toggle keys
---------------------------------------------
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

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
map("", "<leader>l", ":lua toggleln()<CR>", opts)

-- -- Use \m to toggle mouse
map("n", "<leader>m", ':exec &mouse!=""? "set mouse=" : "set mouse=nv"<CR>', opts)

-- Use \o to enable paste mode
map("n", "<leader>o", ":setlocal paste!<CR>", opts)

-- Print filepath (replaces <C-g> which Zellij captures)
map("n", "<leader>p", ":echo expand('%:p')<CR>", opts)

-- Map \c to clear the highlighting from hlsearch
map("n", "<leader>c", ":nohlsearch<CR>", opts)

-- Map \t to toggle Nvim-tree
map("n", "<leader>t", ":NvimTreeFindFileToggle<CR>", opts)

-- dbt: go to schema (dbt.goToSchema via dbtls)
vim.keymap.set("n", "gs", function()
    local client = vim.lsp.get_clients({ bufnr = 0, name = "dbtls" })[1]
    if not client then return vim.notify("dbtls not attached", vim.log.levels.WARN) end
    client.request("workspace/executeCommand", {
        command = "dbt.goToSchema",
        arguments = {
            {
                uri = vim.uri_from_bufnr(0),
                position = { line = vim.fn.line(".") - 1, character = vim.fn.col(".") - 1 },
            },
        },
    }, function(err, result)
        if err then return vim.notify(err.message, vim.log.levels.ERROR) end
        if not result then return vim.notify("No schema found", vim.log.levels.WARN) end
        local path = vim.uri_to_fname(result.uri)
        vim.cmd.edit(path)
        local range = result.range.start
        vim.api.nvim_win_set_cursor(0, { range.line + 1, range.character })
    end, 0)
end, { noremap = true, silent = true })

-- Map \u toggle undo-tree
map("n", "<leader>u", ":UndotreeToggle<CR>", opts)

-- Navigate between windows
map("n", "<C-j>", "<C-W>j", opts)
map("n", "<C-k>", "<C-W>k", opts)
map("n", "<C-h>", "<C-W>h", opts)
map("n", "<C-l>", "<C-W>l", opts)

-- 3-way merge (git mergetool with vimdiff3): pick a side for the hunk under cursor.
-- Use from the MERGED buffer. Pair with ]c / [c to jump between conflicts.
map("n", "<leader>gl", ":diffget LOCAL<CR>",  opts)
map("n", "<leader>gr", ":diffget REMOTE<CR>", opts)
map("n", "<leader>gb", ":diffget BASE<CR>",   opts)
