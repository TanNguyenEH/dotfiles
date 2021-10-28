local MYVIMRC = '$HOME/.config/nvim/init.lua'

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('i', 'jj', '<Esc>', { noremap = false })
map('n', '<Esc>', ':noh<CR>')
map('n', '*', ':let @/=\'\\<<C-R>=expand("<cword>")<CR>\\>\'<CR>:set hls<CR>')
map('n', 'Y', 'y$')
map('n', 'qq', ':q<CR>')
map('n', 'ss', ':w<CR>')

-- Jumplist mutations
map('n', 'k', "(v:count > 5 ? \"m'\" . v:count : \"\") . 'k'", {noremap = true, expr = true})
map('n', 'j', "(v:count > 5 ? \"m'\" . v:count : \"\") . 'j'", {noremap = true, expr = true})

-- Keeping it centered
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')
map('n', 'J', 'mzJ`z')

map('n', '<leader>vc', ':e $MYVIMRC<CR>', {noremap = true, silent = true})
map('n', '<leader>cp', ":let @+=expand('%')<CR>", {noremap = true})
map('n', '<leader><leader>', '<C-^>', {noremap = true})
map('n', '<leader>gf', '<C-w>vgf', {noremap = true})
vim.cmd [[autocmd User Rails nmap <buffer> <leader>gf :vert sfind <Plug><cfile><CR>]]
