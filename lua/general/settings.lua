local o = vim.o
local g = vim.g

o.hidden = true
o.modeline = false
o.swapfile = false
o.hlsearch = true
o.incsearch = true
o.ignorecase = true
o.smartcase = true
o.ruler = true
o.number = true
o.relativenumber = false
o.splitright = true
o.splitbelow = true
o.tabstop = 2
o.shiftwidth = 2
o.softtabstop = 2
o.expandtab = true
o.colorcolumn = '80'
o.list = true
o.scrolloff = 10
o.regexpengine = 1
o.completeopt = 'menuone,noselect'
o.lazyredraw = true
o.termguicolors = true
o.background = 'dark'
o.clipboard = o.clipboard .. 'unnamedplus'
o.mouse = 'a'
o.breakindent = true

g.mapleader = ','

vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]
