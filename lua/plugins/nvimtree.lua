local tree_cb = require("nvim-tree.config").nvim_tree_callback

require('nvim-tree').setup({
  disable_netrw       = true,
  hijack_netrw        = true,
  open_on_setup       = false,
  ignore_ft_on_setup  = {},
  auto_close          = false,
  open_on_tab         = false,
  hijack_cursor       = true,
  update_cwd          = false,
  update_focused_file = {
    enable      = true,
    update_cwd  = true,
    ignore_list = {},
  },
  system_open = {
    cmd  = nil,
    args = {}
  },
  view = {
    width = 30,
    side = 'left',
    auto_resize = false,
    mappings = {
      custom_only = false,
      list = {
        { key = "<CR>", cb = tree_cb("edit") },
        { key = "<2-LeftMouse>", cb = tree_cb("edit") },
        { key = "<2-RightMouse>", cb = tree_cb("cd") },
        { key = "<C-]>", cb = tree_cb("cd") },
        { key = "s", cb = tree_cb("vsplit") },
        { key = "<C-t>", cb = tree_cb("tabnew") },
        { key = "<BS>", cb = tree_cb("close_node") },
        { key = "<S-CR>", cb = tree_cb("close_node") },
        { key = "<Tab>", cb = tree_cb("preview") },
        { key = "I", cb = tree_cb("toggle_ignored") },
        { key = "H", cb = tree_cb("toggle_dotfiles") },
        { key = "R", cb = tree_cb("refresh") },
        { key = "a", cb = tree_cb("create") },
        { key = "d", cb = tree_cb("remove") },
        { key = "r", cb = tree_cb("rename") },
        { key = "<C-r>", cb = tree_cb("full_rename") },
        { key = "x", cb = tree_cb("cut") },
        { key = "c", cb = tree_cb("copy") },
        { key = "p", cb = tree_cb("paste") },
        { key = "[c", cb = tree_cb("prev_git_item") },
        { key = "]c", cb = tree_cb("next_git_item") },
        { key = "-", cb = tree_cb("dir_up") },
        { key = "q", cb = tree_cb("close") },
      }
    }
  }
})

vim.g.nvim_tree_ignore = { "node_modules", ".cache" }

vim.g.nvim_tree_ignore = { "node_modules" }
vim.g.nvim_tree_quit_on_open = 1
vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_hide_dotfiles = 0
vim.g.nvim_tree_width = 30
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_root_folder_modifier = ":~"
vim.g.nvim_tree_width_allow_resize = 1
vim.g.nvim_tree_add_trailing = 1
vim.g.nvim_tree_group_empty = 1
vim.g.nvim_tree_disable_window_picker = 1

vim.api.nvim_set_keymap('n', '<space>n', ':NvimTreeToggle<CR>', {noremap = true})

vim.defer_fn(require("nvim-tree").refresh, 25)
