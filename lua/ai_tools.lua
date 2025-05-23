vim.g.augment_workspace_folders = { "/Users/brianle/Documents/leaf_be", "/Users/brianle/Documents/leaf-fe" }
vim.keymap.set("i", "<C-y>", function()
    vim.fn["augment#Accept"]()
end, { noremap = true, desc = "Accept Augment suggestion" })
