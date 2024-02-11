-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.3',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  
  use({ 
	  'rose-pine/neovim',
	  as = 'rose-pine',
	  config = function()
		  vim.cmd('colorscheme rose-pine')
	  end
  })


  use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

  use('nvim-treesitter/playground') 

  use('ThePrimeagen/harpoon')

  use('mbbill/undotree')

  use('tpope/vim-fugitive')

  use {
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v3.x',
	  requires = {
		  --- Uncomment these if you want to manage LSP servers from neovim
		  -- {'williamboman/mason.nvim'},
		  -- {'williamboman/mason-lspconfig.nvim'},

		  -- LSP Support
		  {'neovim/nvim-lspconfig'},
		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},
		  {'hrsh7th/cmp-nvim-lsp'},
		  {'L3MON4D3/LuaSnip'},
	  }
  }

  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  }

  use "b0o/mapx.nvim"

  use({
      "Pocco81/auto-save.nvim",
      config = function()
          require("auto-save").setup {
              enabled = true
              -- your config goes here
              -- or just leave it empty :)
          }
      end,
  })

  use({ "wbthomason/packer.nvim" })
  use({
    "ray-x/sad.nvim",
    requires = { "ray-x/guihua.lua", run = "cd lua/fzy && make" },
    config = function()
      require("sad").setup{}
    end,
  })

  use 'nvim-tree/nvim-web-devicons'

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

  use "preservim/tagbar"
  use "tpope/vim-commentary"
  use "nvim-tree/nvim-tree.lua"
  use "lukas-reineke/indent-blankline.nvim"

  -- Lua
  use {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }
end)
