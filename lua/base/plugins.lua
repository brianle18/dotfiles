-------------------
-- PACKER INSTALLS --
---------------------

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(
function(use)
    -- Colourscheme
    use 'sainnhe/gruvbox-material'
    -- use 'eddyekofo94/gruvbox-flat.nvim'

    -- Airline themes
    use 'vim-airline/vim-airline'
    use 'vim-airline/vim-airline-themes'

    -- Telescope
    use {'nvim-telescope/telescope.nvim', requires = { {'nvim-lua/plenary.nvim'} } }

    -- Easy-align
    use 'junegunn/vim-easy-align'

    -- Git tools
    use 'tpope/vim-fugitive'
    use 'airblade/vim-gitgutter'

    -- Diff tool
    use 'will133/vim-dirdiff'

    -- commenting <,>Commentary
    use 'tpope/vim-commentary'

    -- Changing surronding using c<OLD><NEW>
    -- Autoclose
    -- Rainbow closing
    use 'tpope/vim-surround'
    use 'Raimondi/delimitMate'
    use 'p00f/nvim-ts-rainbow'

    -- Latex support
    use 'lervag/vimtex'

    -- File viewer
    use { 'nvim-tree/nvim-tree.lua',
            requires = {
                'nvim-tree/nvim-web-devicons', -- optional, for file icons
            },
            tag = 'nightly' -- optional, updated every week. (see issue #1193)
        }
    
    -- Markdown renderer
    use 'ellisonleao/glow.nvim'

    -- LSP stuff
    use {'nvim-treesitter/nvim-treesitter'}
    use {'neoclide/coc.nvim', branch = 'release'}
    use 'nvim-treesitter/playground'
    -- use 'preservim/tagbar'

    -- Undo
    use 'mbbill/undotree'
end)
