local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then

    -- bootstrap lazy.nvim

    -- stylua: ignore

    vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })

end

vim.opt.rtp:prepend(vim.env.LAZY or lazypath)
require("lazy").setup({

    spec = {

        -- add LazyVim and import its plugins


        {
            "dracula/vim",
            enabled = false,
        },
        {
            "folke/tokyonight.nvim",
            enabled = true,
        },
        {
            'marko-cerovac/material.nvim',
            enabled=false,
        },
        "stevearc/dressing.nvim",
        {
            "folke/noice.nvim",
            event = "VeryLazy",
            opts = {
                --        add any options here
            },
            dependencies = {
                --        if you lazy-load any plugin below, make sure to add proper `module="..."` entries
                "MunifTanjim/nui.nvim",
                --        OPTIONAL:
                --          `nvim-notify` is only needed, if you want to use the notification view.
                --          If not available, we use `mini` as the fallback
                "rcarriga/nvim-notify",
            }
        },
        "b0o/mapx.nvim",
        {

            "nvim-telescope/telescope.nvim",

            version = "0.1.3",

            -- or                            , branch = '0.1.x',

            dependencies = { "nvim-lua/plenary.nvim" },
        },
        { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
        {
            "nvim-treesitter/playground",
            enabled = false,
        },
        "nvim-treesitter/nvim-treesitter-context",
        "ThePrimeagen/harpoon",
        {
            "mbbill/undotree",
            lazy = false,
        },
        {
            "tpope/vim-fugitive",
            lazy = true,
        },
        {
            "VonHeikemen/lsp-zero.nvim",
            --            branch = "v3.x",
            dependencies = {

                --- Uncomment these if you want to manage LSP servers from neovim

                {'williamboman/mason.nvim'},

                {'williamboman/mason-lspconfig.nvim'},

                -- LSP Support

                "neovim/nvim-lspconfig",

                -- Autocompletion

                "hrsh7th/nvim-cmp",

                "hrsh7th/cmp-nvim-lsp",

                "L3MON4D3/LuaSnip",

                "rafamadriz/friendly-snippets",

                "saadparwaiz1/cmp_luasnip"
            },
        },
        {

            "Pocco81/auto-save.nvim",

            config = function()
                require("auto-save").setup({
                    enabled = true,
                })
            end,
        },
        {

            "ray-x/sad.nvim",
            dependencies = { "ray-x/guihua.lua", build = "cd lua/fzy && make" },
            config = function()
                require("sad").setup({})
            end,
            lazy = true,
        },
        "nvim-tree/nvim-web-devicons",
        {
            "nvim-lualine/lualine.nvim",
            dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
        },
        {
            "preservim/tagbar",
            lazy = true,
        },
        -- "tpope/vim-commentary",
        {
            'numToStr/Comment.nvim',
            lazy = true,
        },
        "nvim-tree/nvim-tree.lua",

        {
            "lukas-reineke/indent-blankline.nvim",
            lazy = true,
        },
        {
            "folke/which-key.nvim",
            config = function()
                vim.o.timeout = true
                vim.o.timeoutlen = 300
                require("which-key").setup({
                })
            end,
            enabled = false 
        },
        {

            "folke/trouble.nvim",
            opts = {}, -- for default options, refer to the configuration section for custom setup.
            cmd = "Trouble",
            dependencies = { "nvim-tree/nvim-web-devicons" },
            lazy = true
        },
        {
            "github/copilot.vim",
        },
        {
            "CopilotC-Nvim/CopilotChat.nvim",
            branch = "canary",
            dependencies = {
                { "github/copilot.vim" }, -- or github/copilot.vim
                { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
            },
            opts = {
                debug = false, -- Enable debugging
                -- See Configuration section for rest
                window = {
                    layout = 'float',
                    relative = 'cursor',
                    width = 1,
                    height = 0.4,
                    row = 1
                }
            },
            lazy = true,
        },
        {
            "xiyaowong/transparent.nvim",
            lazy = true,
        },

        {
            "folke/todo-comments.nvim",
            dependencies = { "nvim-lua/plenary.nvim" },
            lazy = true,
        },
        {
            'j-hui/fidget.nvim',
            config = function()
                require('fidget').setup{}
            end,
            lazy = true,
        },
        {
            "christoomey/vim-tmux-navigator",
            cmd = {
                "TmuxNavigateLeft",
                "TmuxNavigateDown",
                "TmuxNavigateUp",
                "TmuxNavigateRight",
                "TmuxNavigatePrevious",
            },
            keys = {
                { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
                { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
                { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
                { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
                { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
            },
            lazy = true
        },
        {
            "DragonflyRobotics/ros2-nvim",
            lazy = true,
        },
        "lewis6991/gitsigns.nvim",
        {
            "NeogitOrg/neogit",
            dependencies = {
                "nvim-lua/plenary.nvim",         -- required
                "sindrets/diffview.nvim",        -- optional - Diff integration

                -- Only one of these is needed, not both.
                "nvim-telescope/telescope.nvim", -- optional
                "ibhagwan/fzf-lua",              -- optional
            },
            config = true,
            lazy = false,
        },
        {
            "petertriho/nvim-scrollbar",
            lazy = true
        },
        {
            "kevinhwang91/nvim-hlslens",
            lazy = true
        },
        {
            'Wansmer/treesj',
            dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you install parsers with `nvim-treesitter`
            config = function()
                require('treesj').setup({--[[ your config ]]})
            end,
            lazy = true
        },
        {
            "andymass/vim-matchup",
            lazy = true,
        },
        {
            "RRethy/vim-illuminate",
            lazy = true,
        },
        {
            "cshuaimin/ssr.nvim",
            lazy = true,
        },
        {
            "gbprod/yanky.nvim",
            dependencies = {
                { "kkharji/sqlite.lua" }
            },
            opts = {
                ring = { storage = "sqlite" },
            },
            keys = {
                { "<C-y>", function() require("telescope").extensions.yank_history.yank_history({ }) end, desc = "Open Yank History" },
                { "<C-c>", ":YankyClearHistory<CR>", desc = "Open Yank History" },
                { "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank text" },
                { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after cursor" },
                { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before cursor" },
                { "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after selection" },
                { "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before selection" },
                { "<c-p>", "<Plug>(YankyPreviousEntry)", desc = "Select previous entry through yank history" },
                { "<c-n>", "<Plug>(YankyNextEntry)", desc = "Select next entry through yank history" },
                { "]p", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
                { "[p", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
                { "]P", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
                { "[P", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
                { ">p", "<Plug>(YankyPutIndentAfterShiftRight)", desc = "Put and indent right" },
                { "<p", "<Plug>(YankyPutIndentAfterShiftLeft)", desc = "Put and indent left" },
                { ">P", "<Plug>(YankyPutIndentBeforeShiftRight)", desc = "Put before and indent right" },
                { "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)", desc = "Put before and indent left" },
                { "=p", "<Plug>(YankyPutAfterFilter)", desc = "Put after applying a filter" },
                { "=P", "<Plug>(YankyPutBeforeFilter)", desc = "Put before applying a filter" },
            },
            lazy = true
        },
        {
            'mhinz/vim-startify',
            lazy = false 
        },
        {
            'akinsho/bufferline.nvim',
            dependencies = 'nvim-tree/nvim-web-devicons'
        },
        {
            "mfussenegger/nvim-treehopper",
            lazy = true
        }
    }
})

