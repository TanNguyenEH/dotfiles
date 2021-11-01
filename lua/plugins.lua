return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  -- Color schemes
  use 'jacoborus/tender.vim'
  use {'npxbr/gruvbox.nvim', requires = {'rktjmp/lush.nvim'}}
  use "kyazdani42/nvim-web-devicons"
  use 'ryanoasis/vim-devicons'

  -- Navigation
  use {'junegunn/fzf', run = function() vim.fn['fzf#install']() end}
  use 'junegunn/fzf.vim'
  use 'tpope/vim-projectionist'

  -- File explorer
  use({
    "kyazdani42/nvim-tree.lua",
    requires = "nvim-web-devicons"
  })

  -- Completion
  use 'hrsh7th/nvim-compe'

  -- Statusline
  use { 'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }

  -- Git support
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'junegunn/gv.vim'
  use {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'}}
  use 'kdheepak/lazygit.nvim'

  -- Language support
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use 'nvim-treesitter/nvim-treesitter-refactor'
  use 'neovim/nvim-lspconfig'
  use 'glepnir/lspsaga.nvim'
  use 'galooshi/vim-import-js'
  use 'tpope/vim-rails'

  -- Testing
  use "vim-test/vim-test"

  -- Misc
  use 'airblade/vim-rooter'
  use 'mhinz/vim-startify'
  use 'windwp/nvim-autopairs'
  use 'tpope/vim-surround'
  use 'norcalli/nvim-colorizer.lua'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'b3nj5m1n/kommentary'
  use 'numToStr/Navigator.nvim'
  use "google/vim-jsonnet"
  use 'simrat39/symbols-outline.nvim'
  use 'tversteeg/registers.nvim'
  use 'numtostr/FTerm.nvim'
  use 'wfxr/minimap.vim'
end)
