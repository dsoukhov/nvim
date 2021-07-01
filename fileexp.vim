"nnoremap <leader>f :lua require('nvim-tree_helper').toggle()<CR>
nnoremap <leader>f :NvimTreeToggle<CR>
nnoremap <leader>fr :NvimTreeRefresh<CR>

lua <<EOF
  local tree_cb = require'nvim-tree.config'.nvim_tree_callback
  vim.g.nvim_tree_bindings = {
    ["<C-[>"]  = tree_cb("dir_up"),
  }
EOF
