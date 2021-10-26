local lspconfig = require('lspconfig')
local saga = require('lspsaga')
local api = vim.api

vim.lsp.handlers['textDocument/publishDiagnostics'] = function(...)
  vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
      virtual_text = false,
      underline = true,
      update_in_insert = false,
    }
  )(...)
  pcall(vim.lsp.diagnostic.set_loclist, {open_loclist = false})
end

saga.init_lsp_saga()

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = {noremap = true, silent = true}

  buf_set_keymap('n', '<leader>lf', '<CMD>lua vim.lsp.buf.formatting()<CR>', opts)
  buf_set_keymap('n', '<leader>ld', '<CMD>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<leader>ll', '<CMD>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  buf_set_keymap('n', '<leader>lh', ':Lspsaga hover_doc<CR>', opts)
  buf_set_keymap('n', '<C-f>', ':lua require("lspsaga.action").smart_scroll_with_saga(1)<CR>', opts)
  buf_set_keymap('n', '<C-b>', ':lua require("lspsaga.action").smart_scroll_with_saga(-1)<CR>', opts)

  if client.name == 'solargraph' or client.name == 'tsserver' then
    client.resolved_capabilities.document_formatting = false
  end
end

-- npm install -g typescript typescript-language-server
lspconfig.tsserver.setup({
  on_attach = on_attach,
  flags = {debounce_text_changes = 150},
})

-- gem install solargraph
lspconfig.solargraph.setup({
  on_attach = on_attach,
  flags = {debounce_text_changes = 150}
})

local prettier = {
  formatCommand = 'prettier --stdin-filepath ${INPUT}',
  formatStdin = true,
}

local eslint = {
  lintCommand = 'eslint_d -f visualstudio --stdin --stdin-filename ${INPUT}',
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = {'%f(%l,%c): %tarning %m', '%f(%l,%c): %trror %m'},
}

local rubocop = {
  lintCommand = 'rubocop --format emacs --force-exclusion --stdin ${INPUT}',
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = {'%f:%l:%c: %t: %m'},
  formatCommand = 'rubocop --auto-correct --force-exclusion --stdin ${INPUT} 2>/dev/null | sed "1,/^====================$/d"',
  formatStdin = true,
}

-- brew install efm-langserver
-- npm install -g eslint_d
lspconfig.efm.setup({
  init_options = {documentFormatting = true, codeAction = true},
  filetypes = {'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'ruby', 'json'},
  settings = {
    languages = {
      javascript = {prettier, eslint},
      javascriptreact = {prettier, eslint},
      typescript = {prettier, eslint},
      typescriptreact = {prettier, eslint},
      ruby = {rubocop},
      json = {prettier},
    }
  },

  on_attach = on_attach,
  flags = {debounce_text_changes = 150}
})
