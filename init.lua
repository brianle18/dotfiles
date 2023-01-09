require("base.format")
require("base.search")
require("base.colours")
require("base.mappings")
require("base.vimtex")
require("base.coc")
require("base.ts")
require("base.languages")
require("base.plugins")

-- Testing
local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')
Plug 'fabiosal/vim-find-test'
vim.call('plug#end')
vim.g.python3_host_prog = '/opt/homebrew/bin/python3'
