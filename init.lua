local g = vim.g
local fn = vim.fn
local start_time = fn.reltime()

require('general/settings')
require('general/mappings')

require('colorschemes/gruvbox')

require('plugins')
require('plugins/fzf')
require('plugins/compe')
require('plugins/lualine')
require('plugins/nvimtree')
require('plugins/fugitive')
require('plugins/gitsigns')
require('plugins/treesitter')
require('plugins/lsp')
require('plugins/autopairs')
require('plugins/navigator')
require('plugins/kommentary')
require('plugins/colorizer')
require('plugins/blankline')
require('plugins/fterm')
require('plugins/vim-rooter')
require('plugins/vim-startify')
require('plugins/lazygit')

print('Loaded in ' .. fn.printf('%.3f', fn.reltimefloat(fn.reltime(start_time))) .. ' seconds.')
