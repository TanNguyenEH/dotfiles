require'FTerm'.setup({
    border = 'double',
    dimensions  = {
      height = 0.8,
      width = 0.8,
      x = 0.5,
      y = 0.5
    },
})

-- Example keybindings
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('n', 'zz', '<CMD>lua require("FTerm").toggle()<CR>', opts)
map('t', 'zz', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', opts)
