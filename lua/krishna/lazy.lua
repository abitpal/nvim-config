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
    'marko-cerovac/material.nvim',
    "stevearc/dressing.nvim",
  --   {
  -- "folke/noice.nvim",
  --     event = "VeryLazy",
  --     opts = {
        -- add any options here
  --     },
  --     dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
  --       "MunifTanjim/nui.nvim",
        -- OPTIONAL:
        --   `nvim-notify` is only needed, if you want to use the notification view.
        --   If not available, we use `mini` as the fallback
  --       "rcarriga/nvim-notify",
  --       }
  --   },
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
		branch = "v3.x",
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

	"tpope/vim-commentary",

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
	},

	{

		"folke/trouble.nvim",

		dependencies = { "nvim-tree/nvim-web-devicons" },
	},


  }
})
