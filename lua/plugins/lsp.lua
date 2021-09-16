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

saga.init_lsp_saga {
  error_sign = "",
  warn_sign = "",
  infor_sign = "",
  hint_sign = "",
  finder_definition_icon = '  ',
  finder_reference_icon = '  ',
  finder_action_keys = {
    open = "o",
    vsplit = "v",
    split = "s",
    quit = "q",
    scroll_down = "<C-f>",
    scroll_up = "<C-b>", -- quit can be a table
  },
}

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = {noremap = true, silent = true}

  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gl', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>:w<CR>', opts)
  buf_set_keymap('n', '<leader>lh', ':Lspsaga hover_doc<CR>', opts)

  if client.name == 'solargraph' or client.name == 'tsserver' then
    client.resolved_capabilities.document_formatting = false
  end
end

-- npm install -g typescript typescript-language-server
lspconfig.tsserver.setup({
  on_attach = on_attach,
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

  on_attach = on_attach,
  flags = {debounce_text_changes = 150}
})

-- npm install -g ocaml-language-server
-- opam switch create 4.06.0
-- eval $(opam env)
-- opam install reason merlin
lspconfig.ocamlls.setup({
  on_attach = on_attach,
  flags = {debounce_text_changes = 150}
})

lspconfig.rescriptls.setup({
  cmd = {
    'node',
    '/Users/toannguyen/.local/share/nvim/site/pack/packer/start/vim-rescript/server/out/server.js',
    '--stdio'
  },

  on_attach = on_attach,
  flags = {debounce_text_changes = 150}
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
  lintCommand = 'bundle exec rubocop --format emacs --force-exclusion --stdin ${INPUT}',
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = {'%f:%l:%c: %t: %m'},
  formatCommand = 'bundle exec rubocop --auto-correct --force-exclusion --stdin ${INPUT} 2>/dev/null | sed "1,/^====================$/d"',
  formatStdin = true,
}

-- brew install efm-langserver
-- npm install -g eslint_d
-- npm install -g prettier
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
      json = {prettier, eslint},
      ["javascript.jsx"] = {prettier, eslint},
      ["typescript.tsx"] = {prettier, eslint},
    }
  },

  on_attach = on_attach,
  flags = {debounce_text_changes = 150}
})