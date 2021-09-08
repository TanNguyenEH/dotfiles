local MYVIMRC = '$HOME/.config/nvim/init.lua'

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('i', 'jj', '<Esc>', { noremap = false }) -- Cancel insert mode
map('n', '<Space>', ':') -- Open comman mode
map('n', '<leader>h', ':let @/=\'\\<<C-R>=expand("<cword>")<CR>\\>\'<CR>:set hls<CR>') -- Highlight word
map('n', '<leader>l', ":noh<CR>") -- Cancel highligh word
map('n', 'Y', 'y$') -- Copy from current cursor to end of the line
map('n', 'qq', ':q<CR>') -- Quite file by qq
map('n', '<leader>cp', ":let @+=expand('%:p')<CR>") -- Copy current path for current file
map('n', 'vwp', 'viw"0p')
map('n', '<leader><leader>', '<C-^>')
map('n', '<leader>v', ':vsplit<CR>')

-- Jumplist mutations
map('n', 'k', "(v:count > 5 ? \"m'\" . v:count : \"\") . 'k'", {noremap = true, expr = true})
map('n', 'j', "(v:count > 5 ? \"m'\" . v:count : \"\") . 'j'", {noremap = true, expr = true})
