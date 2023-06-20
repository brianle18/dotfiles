-------------------
-- PACKER INSTALLS --
---------------------

vim.cmd [[packadd packer.nvim]]
require("packer").init({
    git = {
        clone_timeout = 120, -- Timeout, in seconds, for git clones
    }
})

return require('packer').startup(
function(use)
    -- Colourscheme
    use 'sainnhe/gruvbox-material'
    -- use 'eddyekofo94/gruvbox-flat.nvim'
    use 'norcalli/nvim-colorizer.lua'

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
    -- \cc
    use 'tpope/vim-commentary'
    use 'preservim/nerdcommenter'

    -- Highlighting commentary
    use { 'folke/todo-comments.nvim',
            requires = { { "nvim-lua/plenary.nvim" } },
            cmd = {"TodoQuickFix", "TodoTrouble", "TodoTelescope"}
        }

    -- Changing surronding using c<OLD><NEW>
    -- Autoclose
    -- Rainbow closing
    use 'tpope/vim-surround'
    use 'Raimondi/delimitMate'
    use 'p00f/nvim-ts-rainbow'

    -- Latex support
    use 'lervag/vimtex'
    -- use 'matze/vim-tex-fold'

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

    -- Linter
    use 'dense-analysis/ale'

    -- Test tabnine
    use { 'codota/tabnine-vim', run = './dl_binaries.sh' }

    -- Trailing whitespace (missing from ALE)
    use { 'lukoshkin/highlight-whitespace',
           config = function ()
              require'highlight-whitespace'.setup {
                 tws = '\\s\\+$',
                 markdown = { tws = 'RosyBrown' },
                 other = { tws = 'PaleVioletRed' },
              }
           end
        }

    -- Undo
    use 'mbbill/undotree'

    -- Alternative searching
    use {'junegunn/fzf', dir = '~/.fzf', run = './install --all' }
    use 'jremmen/vim-ripgrep'

    -----------------------
    -- LANGUAGE-SPECIFIC --
    -----------------------
    use {'python-mode/python-mode', branch='develop'}
    use 'jeetsukumaran/vim-pythonsense'
end)
