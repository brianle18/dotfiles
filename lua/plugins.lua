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

-- TODO migrate specs to individual files
require("lazy").setup({
    { "wbthomason/packer.nvim" },
    -- Colourscheme
    "sainnhe/gruvbox-material",
    "folke/tokyonight.nvim",
    "norcalli/nvim-colorizer.lua",

    -- Line themes,
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },

    -- Telescope,
    { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
    { "nvim-telescope/telescope-ui-select.nvim", dependencies = { "nvim-telescope/telescope.nvim" } },

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
        opts = {},
    },

    -- Changing surronding using c<OLD><NEW>
    -- Autoclose
    -- Rainbow closing
    "tpope/vim-surround",
    "Raimondi/delimitMate",
    "HiPhish/rainbow-delimiters.nvim",

    -- Latex support
    "lervag/vimtex",

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

    -- Alternative (ranger style)
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

    -- Formatters
    "jose-elias-alvarez/null-ls.nvim",
    "MunifTanjim/prettier.nvim",
    "stevearc/conform.nvim",

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
    { "hrsh7th/cmp-omni" },
    { "hrsh7th/cmp-cmdline" },

    -- snippets
    { "L3MON4D3/LuaSnip", run = "make install_jsregexp" },
    { "saadparwaiz1/cmp_luasnip" },

    -- Bracketing
    { "tpope/vim-unimpaired" },

    -- Copilot
    { "github/copilot.vim" },

    -- Trailing whitespace
    {
        "lukoshkin/highlight-whitespace",
        config = function()
            require("highlight-whitespace").setup({
                tws = "\\s\\+$",
                palette = {
                    markdown = { tws = "RosyBrown" },
                    other = { tws = "PaleVioletRed" },
                },
            })
        end,
    },

    -- Undo
    "mbbill/undotree",

    -- Alternative searching
    "jremmen/vim-ripgrep",

    -- Debugging
    {
        "rcarriga/nvim-notify",
        config = function()
            vim.notify = require("notify")
            vim.notify.setup({
                background_colour = "#000000",
            })
        end,
    },

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
    { "vim-scripts/dbext.vim" },

    -- Elixir objects and formatting
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
