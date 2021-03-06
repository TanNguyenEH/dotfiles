local g = vim.g
local api = vim.api

g['sneak#label'] = 1
g['sneak#use_ic_scs'] = 1

api.nvim_set_keymap('', 'f', '<Plug>Sneak_f', {noremap = false})
api.nvim_set_keymap('', 'F', '<Plug>Sneak_F', {noremap = false})
api.nvim_set_keymap('', 't', '<Plug>Sneak_t', {noremap = false})
api.nvim_set_keymap('', 'T', '<Plug>Sneak_T', {noremap = false})

vim.cmd [[autocmd ColorScheme * highlight Sneak      guifg=#282828 guibg=#fabd2f]]
vim.cmd [[autocmd ColorScheme * highlight SneakLabel guifg=#282828 guibg=#fabd2f]]

