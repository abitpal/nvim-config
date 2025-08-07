local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then

    -- bootstrap lazy.nvim

    -- stylua: ignore

    vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end

vim.opt.rtp:prepend(vim.env.LAZY or lazypath)
require("lazy").setup({

	spec = {
		-- UI Plugins
		{
			"folke/tokyonight.nvim",
			enabled = true,
		},
		"nvim-tree/nvim-web-devicons",
		{
			"nvim-lualine/lualine.nvim",
			dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
		},
		{
			"preservim/tagbar",
			lazy = false,
		},
		"nvim-tree/nvim-tree.lua",
		{
			"lukas-reineke/indent-blankline.nvim",
			lazy = true,
		},
		{
			"xiyaowong/transparent.nvim",
			lazy = true,
		},

		-- Shortcut plugins
		"b0o/mapx.nvim",

		-- Editor and LSP
		{
			"nvim-telescope/telescope.nvim",
			version = "0.1.3",
			dependencies = { "nvim-lua/plenary.nvim" },
		},
		{
			"mrcjkb/rustaceanvim",
			version = "^6", -- Recommended
			lazy = false, -- This plugin is already lazy
		},
		"rust-lang/rust.vim",
		{
			"saecki/crates.nvim",
			tag = "stable",
			config = function()
				require("crates").setup()
			end,
		},
		{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
		{
			"nvim-treesitter/playground",
			enabled = false,
		},
		"nvim-treesitter/nvim-treesitter-context",
		{
			"L3MON4D3/LuaSnip",
			-- follow latest release.
			version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
			-- install jsregexp (optional!).
			build = "make install_jsregexp",
		},
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		{
			"saghen/blink.cmp",
			-- optional: provides snippets for the snippet source
			dependencies = { "rafamadriz/friendly-snippets" },

			-- use a release tag to download pre-built binaries
			version = "1.*",
			-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
			-- build = 'cargo build --release',
			-- If you use nix, you can build from source using latest nightly rust with:
			-- build = 'nix run .#build-plugin',

			---@module 'blink.cmp'
			---@type blink.cmp.Config
			opts_extend = { "sources.default" },
		},
		{
			"neovim/nvim-lspconfig",
			dependencies = { "saghen/blink.cmp" },
		},
		"stevearc/conform.nvim",
		{
			"nvimtools/none-ls.nvim",
			dependencies = {
				"nvimtools/none-ls-extras.nvim",
			},
		},
		"onsails/lspkind.nvim",
		{
			"folke/trouble.nvim",
			opts = {}, -- for default options, refer to the configuration section for custom setup.
			cmd = "Trouble",
			dependencies = { "nvim-tree/nvim-web-devicons" },
			lazy = true,
		},
		{
			"github/copilot.vim",
		},
		{
			"olimorris/codecompanion.nvim",
			config = true,
			dependencies = {
				"nvim-lua/plenary.nvim",
				"nvim-treesitter/nvim-treesitter",
			},
		},
		{
			"folke/todo-comments.nvim",
			dependencies = { "nvim-lua/plenary.nvim" },
			lazy = true,
		},
		{
			"nvim-pack/nvim-spectre",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"nvim-tree/nvim-web-devicons",
			},
		},

		-- Navigation
		{
			"folke/which-key.nvim",
			config = function()
				vim.o.timeout = true
				vim.o.timeoutlen = 300
				require("which-key").setup({})
			end,
			enabled = false,
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
			lazy = true,
			enabled = true,
		},
		{
			"smoka7/multicursors.nvim",
			event = "VeryLazy",
			dependencies = {
				"nvimtools/hydra.nvim",
			},
			opts = {},
			cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
			keys = {
				{
					mode = { "v", "n" },
					"<Leader>m",
					"<cmd>MCstart<cr>",
					desc = "Create a selection for selected text or word under the cursor",
				},
			},
		},
		{
			"tris203/precognition.nvim",
			opts = {
				startVisible = false, -- start with the preview window visible
			},
		},
		{
			"ggandor/leap.nvim",
			dependencies = {
				"tpope/vim-repeat", -- for repeating the last leap command
			},
		},

		-- Utilities
		{ "mbbill/undotree", lazy = false },
		{ "tpope/vim-fugitive", lazy = true },
		{
			"Pocco81/auto-save.nvim",
			config = function()
				require("auto-save").setup({
					enabled = true,
				})
			end,
		},
		{
			"numToStr/Comment.nvim",
			lazy = true,
		},
		"nosduco/remote-sshfs.nvim",
		"nvimdev/lspsaga.nvim",

		{
			"j-hui/fidget.nvim",
			lazy = true,
		},
		"lewis6991/gitsigns.nvim",
		{
			"NeogitOrg/neogit",
			dependencies = {
				"nvim-lua/plenary.nvim", -- required
				"sindrets/diffview.nvim", -- optional - Diff integration

				-- Only one of these is needed, not both.
				"nvim-telescope/telescope.nvim", -- optional
				"ibhagwan/fzf-lua", -- optional
			},
			config = true,
			lazy = false,
		},
		{
			"petertriho/nvim-scrollbar",
			lazy = true,
		},
		{
			"kevinhwang91/nvim-hlslens",
			lazy = true,
		},
		{
			"Wansmer/treesj",
			dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
			config = function()
				require("treesj").setup({--[[ your config ]]
				})
			end,
			lazy = true,
		},
		{
			"RRethy/vim-illuminate",
			lazy = true,
		},
		{
			"kevinhwang91/nvim-ufo",
			dependencies = {
				"kevinhwang91/promise-async",
			},
		},
		{
			"cshuaimin/ssr.nvim",
			lazy = true,
		},
		{
			"akinsho/bufferline.nvim",
			dependencies = "nvim-tree/nvim-web-devicons",
		},
		{
			"mfussenegger/nvim-treehopper",
			lazy = true,
		},
		{ -- The task runner we use
			"stevearc/overseer.nvim",
			commit = "400e762648b70397d0d315e5acaf0ff3597f2d8b",
			cmd = { "MakeitOpen", "MakeitToggleResults", "MakeitRedo" },
			opts = {
				task_list = {
					direction = "bottom",
					min_height = 25,
					max_height = 25,
					default_detail = 1,
				},
			},
		},
		{
			"nvimdev/dashboard-nvim",
			event = "VimEnter",
			dependencies = { { "nvim-tree/nvim-web-devicons" } },
		},
	},
})
