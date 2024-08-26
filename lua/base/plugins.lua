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
    use {'wbthomason/packer.nvim'}
    -- Colourscheme
    use 'sainnhe/gruvbox-material'
    use 'folke/tokyonight.nvim'
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
    -- gcc (used for embedded languages)
    use 'JoosepAlviste/nvim-ts-context-commentstring'
    use 'numToStr/Comment.nvim'

    -- Highlighting commentary
    use { 'folke/todo-comments.nvim',
            requires = { { "nvim-lua/plenary.nvim" } },
            cmd = {"TodoList", "TodoQuickFix", "TodoTrouble", "TodoTelescope"}
        }

    -- Changing surronding using c<OLD><NEW>
    -- Autoclose
    -- Rainbow closing
    use 'tpope/vim-surround'
    use 'Raimondi/delimitMate'
    -- use 'p00f/nvim-ts-rainbow'
    use 'HiPhish/rainbow-delimiters.nvim'

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
    use {"ellisonleao/glow.nvim", config = function() require("glow").setup() end}
    -- install without yarn or npm
    -- use({
    --     "iamcco/markdown-preview.nvim",
    --     run = function() vim.fn["mkdp#util#install"]() end,
    -- })

    use({
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })

    -- LSP stuff
    use {'nvim-treesitter/nvim-treesitter', dependencies = {'JoosepAlviste/nvim-ts-context-commentstring'}}
    use {'neoclide/coc.nvim', branch = 'release'}
    use {'elixir-lsp/coc-elixir', run = 'yarn install && yarn prepack'}
    use 'nvim-treesitter/playground'
    use "williamboman/nvim-lsp-installer"
    use{'neovim/nvim-lspconfig', opts = {
        inlay_hints = {enabled = false},
    }}
    use{
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = function()
            require("lsp_lines").setup()
        end,
    }
    use 'jose-elias-alvarez/null-ls.nvim'
    use 'MunifTanjim/prettier.nvim'
    -- use 'preservim/tagbar'
    -- Embedded languages
    use 'stevearc/conform.nvim'
    -- use({"dariuscorvus/tree-sitter-language-injection.nvim", after="nvim-treesitter"})

    -- Some stuff for elixir
    -- cmp framework for auto-completion support
    use {'hrsh7th/nvim-cmp'}
    use {'andyl/vim-textobj-elixir'}
    use {'kana/vim-textobj-user'}
    use {'mhinz/vim-mix-format'}
    use({
      "nvim-treesitter/nvim-treesitter-textobjects",
      after = "nvim-treesitter",
      requires = "nvim-treesitter/nvim-treesitter",
    })

    -- install different completion source
    use {'hrsh7th/cmp-nvim-lsp'}
    use {'hrsh7th/cmp-buffer'}
    use {'hrsh7th/cmp-path'}
    use {'hrsh7th/cmp-cmdline'}
    -- use {'tzachar/cmp-tabnine', run='./install.sh', requires = 'hrsh7th/nvim-cmp'}

    -- snippets
    use {'L3MON4D3/LuaSnip', run = "make install_jsregexp"}
    use {'saadparwaiz1/cmp_luasnip'}

    -- Linter
    use 'dense-analysis/ale'

    -- Bracketing
    use {'tpope/vim-unimpaired'}

    -- Test AI
    -- use { 'codota/tabnine-vim', run = './dl_binaries.sh' }
    use { 'github/copilot.vim' }
    -- use { "zbirenbaum/copilot.lua",
    --     cmd = "Copilot",
    --     event = "InsertEnter",
    --     config = function() require("copilot").setup() end
    -- }
    -- use { "zbirenbaum/copilot-cmp",
    --         after = { "copilot.lua" },
    --         config = function () require("copilot_cmp").setup()
    --       end
    --     }

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

    -- Graphiql codegen 
    use { 'Equilibris/nx.nvim',
	    requires = {
		'nvim-telescope/telescope.nvim',
	    },
	    }
end)
