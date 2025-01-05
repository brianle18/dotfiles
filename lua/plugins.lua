-------------------
-- PACKER INSTALLS --
---------------------

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { "wbthomason/packer.nvim" },
    -- Colourscheme
    "sainnhe/gruvbox-material",
    "folke/tokyonight.nvim",
    "norcalli/nvim-colorizer.lua",

    -- Airline themes,
    "vim-airline/vim-airline",
    "vim-airline/vim-airline-themes",

    -- Telescope,
    { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

    -- Easy-align,
    "junegunn/vim-easy-align",

    -- Git tools,
    "tpope/vim-fugitive",
    "airblade/vim-gitgutter",

    -- Diff tool,
    "will133/vim-dirdiff",

    -- commenting <,>Commentary,
    -- \cc,
    "tpope/vim-commentary",
    "preservim/nerdcommenter",
    -- gcc (used for embedded languages),
    "JoosepAlviste/nvim-ts-context-commentstring",
    "numToStr/Comment.nvim",

    -- Highlighting commentary
    {
        "folke/todo-comments.nvim",
        dependencies = { { "nvim-lua/plenary.nvim" } },
        cmd = { "TodoList", "TodoQuickFix", "TodoTrouble", "TodoTelescope" },
    },

    -- Changing surronding using c<OLD><NEW>
    -- Autoclose
    -- Rainbow closing
    "tpope/vim-surround",
    "Raimondi/delimitMate",
    "HiPhish/rainbow-delimiters.nvim",

    -- Latex support
    "lervag/vimtex",
    -- 'matze/vim-tex-fold'

    -- File viewer
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup({})
        end,
    },
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },

    -- Markdown renderer
    {
        "ellisonleao/glow.nvim",
        config = function()
            require("glow").setup()
        end,
    },
    {
        "iamcco/markdown-preview.nvim",
        build = "cd app && npm install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    },

    -- LSP stuff
    { "nvim-treesitter/nvim-treesitter", dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" } },
    { "neoclide/coc.nvim", branch = "release" },
    { "elixir-lsp/coc-elixir", run = "yarn install && yarn prepack" },
    "nvim-treesitter/playground",
    {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },
    {
        "neovim/nvim-lspconfig",
        lazy = {
            inlay_hints = { enabled = false },
        },
    },
    -- Format into lines
    {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = function()
            require("lsp_lines").setup()
        end,
    },
    "jose-elias-alvarez/null-ls.nvim",
    "MunifTanjim/prettier.nvim",
    -- 'preservim/tagbar'

    -- Embedded languages
    "stevearc/conform.nvim",
    -- use({"dariuscorvus/tree-sitter-language-injection.nvim", after="nvim-treesitter"})

    -- cmp framework for auto-completion support
    { "hrsh7th/nvim-cmp" },

    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = "nvim-treesitter/nvim-treesitter",
    },

    -- install different completion source
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-cmdline" },
    -- {'tzachar/cmp-tabnine', run='./install.sh', dependencies = 'hrsh7th/nvim-cmp'}
    --

    -- snippets
    { "L3MON4D3/LuaSnip", run = "make install_jsregexp" },
    { "saadparwaiz1/cmp_luasnip" },

    -- Linter
    "dense-analysis/ale",

    -- Bracketing
    { "tpope/vim-unimpaired" },

    -- Test AI
    -- { 'codota/tabnine-vim', run = './dl_binaries.sh' }
    { "github/copilot.vim" },
    -- { "zbirenbaum/copilot.lua",
    --     cmd = "Copilot",
    --     event = "InsertEnter",
    --     config = function() require("copilot").setup() end
    -- }
    -- { "zbirenbaum/copilot-cmp",
    --         after = { "copilot.lua" },
    --         config = function () require("copilot_cmp").setup()
    --       end
    --     }

    -- Trailing whitespace (missing from ALE)
    {
        "lukoshkin/highlight-whitespace",
        config = function()
            require("highlight-whitespace").setup({
                tws = "\\s\\+$",
                markdown = { tws = "RosyBrown" },
                other = { tws = "PaleVioletRed" },
            })
        end,
    },

    -- Undo
    "mbbill/undotree",

    -- Alternative searching
    -- {'junegunn/fzf', dir = '~/.fzf', build = './install --all' },
    "jremmen/vim-ripgrep",

    -----------------------
    -- LANGUAGE-SPECIFIC --
    -----------------------
    { "python-mode/python-mode", branch = "develop" },
    "jeetsukumaran/vim-pythonsense",

    -- Graphiql codegen
    {
        "Equilibris/nx.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
    },
    -- SQL
    { "tpope/vim-dadbod" },
    {
        "kristijanhusak/vim-dadbod-ui",
        dependencies = {
            { "tpope/vim-dadbod", lazy = true },
            { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional },
        },
    },
    -- elixir objects and formatting
    -- something wrong here
    -- { "kana/vim-textobj-user", init = function() end },
    -- { "andyl/vim-textobj-elixir" },
    { "elixir-editors/vim-elixir" },
    { "sodapopcan/vim-mixer", lazy = false, dependencies = "elixir-editors/vim-elixir" },
    {
        "mhinz/vim-mix-format",
        lazy = false,
    },
})
