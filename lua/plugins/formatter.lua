require('formatter').setup({
  logging = false,
  filetype = {
    javascript = {
      function()
        return {
          exe = "prettier",
          args = {vim.api.nvim_buf_get_name(0)},
          stdin = true
        }
      end
    },

  filetype = {
    ruby = {
       -- rubocop
       function()
         return {
           exe = "rubocop", -- might prepend `bundle exec `
           args = { '--auto-correct', '--stdin', '%:p', '2>/dev/null', '|', "awk 'f; /^====================$/{f=1}'"},
           stdin = true,
         }
       end
     }
  }
  }
})
