local lspconfig = require('lspconfig')
local lsp_status = require('lsp-status')
local saga = require('lspsaga')
local api = vim.api

lsp_status.register_progress()

saga.init_lsp_saga()

vim.lsp.handlers['textDocument/publishDiagnostics'] = function(...)
  vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
      virtual_text = false,
      underline = true,
      update_in_insert = false,
    }
  )(...)

  if vim.lsp.buf.server_ready() then
    pcall(vim.diagnostic.setloclist, {open = false})
  end
end

local common_on_attach = function(client, bufnr)
  lsp_status.on_attach(client)

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = {noremap = true, silent = true}

  buf_set_keymap('n', '<leader>lf', '<CMD>lua vim.lsp.buf.formatting()<CR>', opts)
  buf_set_keymap('n', '<leader>ld', '<CMD>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<leader>lr', '<CMD>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>ll', '<CMD>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  buf_set_keymap('n', '<leader>lh', ':Lspsaga hover_doc<CR>', opts)
  buf_set_keymap('n', '<C-f>', ':lua require("lspsaga.action").smart_scroll_with_saga(1)<CR>', opts)
  buf_set_keymap('n', '<C-b>', ':lua require("lspsaga.action").smart_scroll_with_saga(-1)<CR>', opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
capabilities = vim.tbl_extend('keep', capabilities, lsp_status.capabilities)

-- npm install -g typescript typescript-language-server
lspconfig.tsserver.setup({
  on_attach = function(client, bufnr)
    common_on_attach(client, bufnr)
    client.resolved_capabilities.document_formatting = false
  end,
  capabilities = capabilities,
  flags = {debounce_text_changes = 150},
})

-- curl -fLO https://github.com/elixir-lsp/elixir-ls/releases/latest/download/elixir-ls.zip
-- unzip elixir-ls.zip -d /usr/local/bin/elixir-ls
-- chmod +x /usr/local/bin/elixir-ls/language_server.sh
lspconfig.elixirls.setup({
  cmd = {'/usr/local/bin/elixir-ls/language_server.sh'},
  settings = {
    ['elixirLS.dialyzerEnabled'] = true,
    ['elixirLS.dialyzerFormat'] = 'dialyzer',
    ['elixirLS.dialyzerWarnOpts'] = {},
    ['elixirLS.fetchDeps'] = true,
    ['elixirLS.mixEnv'] = 'test',
    ['elixirLS.suggestSpecs'] = true,
  },

  on_attach = common_on_attach,
  capabilities = capabilities,
  flags = {debounce_text_changes = 150}
})

-- gem install solargraph
lspconfig.solargraph.setup({
  on_attach = function(client, bufnr)
    common_on_attach(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.goto_definition = false
  end,
  capabilities = capabilities,
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

local pandoc = {
  formatCommand = 'pandoc -f gfm -t gfm -sp --tab-stop=2 --wrap=none',
  formatStdin = true,
}

-- brew install efm-langserver
-- npm install -g eslint_d
lspconfig.efm.setup({
  root_dir = lspconfig.util.root_pattern('.git', 'package.json'),
  init_options = {documentFormatting = true, codeAction = false},
  filetypes = {'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'ruby', 'json', 'markdown'},
  settings = {
    languages = {
      javascript = {prettier, eslint},
      javascriptreact = {prettier, eslint},
      typescript = {prettier, eslint},
      typescriptreact = {prettier, eslint},
      ruby = {rubocop},
      json = {prettier},
      markdown = {pandoc},
    }
  },

  on_attach = function(client, bufnr)
    common_on_attach(client, bufnr)
    -- client.resolved_capabilities.goto_definition = false
  end,
  flags = {debounce_text_changes = 150}
})

