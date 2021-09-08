return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Color schemes
  use 'jacoborus/tender.vim'
  -- use {'npxbr/gruvbox.nvim', requires = {'rktjmp/lush.nvim'}}
  use "folke/tokyonight.nvim"

  -- Search text, search file
  -- use {'junegunn/fzf', run = function() vim.fn['fzf#install']() end}
  -- use 'junegunn/fzf.vim'
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use { 'nvim-telescope/telescope-fzy-native.nvim', run='git submodule update --init --recursive' }
  use {'phaazon/hop.nvim', as = 'hop'}

  -- File explorer
  use({
    "kyazdani42/nvim-tree.lua",
    requires = "nvim-web-devicons"
  })

  -- Completion
  use 'hrsh7th/nvim-compe'

  -- Statusline
  use {'shadmansaleh/lualine.nvim', requires = {'kyazdani42/nvim-web-devicons', opt = true}}

  -- Git support
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'junegunn/gv.vim'
  use {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'}}

  -- Language support
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use 'nvim-treesitter/nvim-treesitter-refactor'
  use 'neovim/nvim-lspconfig'
  use 'glepnir/lspsaga.nvim'
  use 'reasonml-editor/vim-reason-plus'
  use 'rescript-lang/vim-rescript'
  use 'tpope/vim-rails'
  use 'galooshi/vim-import-js'

  -- Misc
  use 'windwp/nvim-autopairs'
  use 'tpope/vim-surround'
  use 'norcalli/nvim-colorizer.lua'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'b3nj5m1n/kommentary'
  use 'numToStr/Navigator.nvim'
end)
