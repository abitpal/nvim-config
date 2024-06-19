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


        "tjdevries/colorbuddy.nvim",
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
        "nvim-treesitter/playground",
        "ThePrimeagen/harpoon",
        "mbbill/undotree",
        "tpope/vim-fugitive",
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

                    -- your config goes here

                    -- or just leave it empty :)
                })
            end,
        },

        {

            "ray-x/sad.nvim",

            dependencies = { "ray-x/guihua.lua", build = "cd lua/fzy && make" },

            config = function()
                require("sad").setup({})
            end,
        },

        "nvim-tree/nvim-web-devicons",

        {

            "nvim-lualine/lualine.nvim",

            dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
        },

        "preservim/tagbar",

        -- "tpope/vim-commentary",
        {
            'numToStr/Comment.nvim',
            opts = {
                -- add any options here
            },
            lazy = false,
        },

        "nvim-tree/nvim-tree.lua",

        "lukas-reineke/indent-blankline.nvim",

        -- Lua

        {

            "folke/which-key.nvim",

            config = function()
                vim.o.timeout = true

                vim.o.timeoutlen = 300

                require("which-key").setup({

                    -- your configuration comes here

                    -- or leave it empty to use the default settings

                    -- refer to the configuration section below
                })
            end,
            enabled = false
        },

        {

            "folke/trouble.nvim",

            dependencies = { "nvim-tree/nvim-web-devicons" },
        },
        "github/copilot.vim",

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
            -- See Commands section for default commands if you want to lazy load on them
            keys = {
                {
                    "<leader>zh",
                    function()
                        local actions = require("CopilotChat.actions")
                        require("CopilotChat.integrations.telescope").pick(actions.help_actions())
                    end,
                    desc = "CopilotChat - Help actions",
                },
                {
                    "<leader>zz",
                    function()
                        local actions = require("CopilotChat.actions")
                        require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
                    end,
                    desc = "CopilotChat - Prompt actions",
                },
            },
        },

        "xiyaowong/transparent.nvim",

        {
            "folke/todo-comments.nvim",
            dependencies = { "nvim-lua/plenary.nvim" },
        },

        "dracula/vim",
        {
            'j-hui/fidget.nvim',
            config = function()
                require('fidget').setup{}
            end
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
        },
        "DragonflyRobotics/ros2-nvim",
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
            config = true
        },
        "petertriho/nvim-scrollbar",
        "kevinhwang91/nvim-hlslens",
        {
            'Wansmer/treesj',
            dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you install parsers with `nvim-treesitter`
            config = function()
                require('treesj').setup({--[[ your config ]]})
            end,
        },
        "andymass/vim-matchup",
        "RRethy/vim-illuminate",
        "cshuaimin/ssr.nvim",
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
        },
        'mhinz/vim-startify'
    }
})

