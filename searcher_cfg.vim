" set telescope bindings
lua << EOF
-- close on single exit
local actions = require('telescope.actions')

require('telescope').setup{
  defaults = {
    layout_config = {
      vertical = { width = 0.95 }
    },
    scroll_strategy    = "cycle",
    selection_strategy = "reset",
    layout_strategy    = "vertical",
    mappings = {
      n = {
        ["<Esc>"] = actions.close,
        ["<CR>"]  = actions.select_default + actions.center,
        ["<C-v>"] = actions.select_vertical,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-t>"] = actions.select_tab,
        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
      },
      i = {
        ["<Esc>"] = actions.close,
        ["<CR>"]  = actions.select_default + actions.center,
        ["<C-v>"] = actions.select_vertical,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-t>"] = actions.select_tab,
        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
      },
    },
  }
}
require("telescope").load_extension("dir")
vim.keymap.set('n', '<leader>sr', '<cmd>lua require("spectre").toggle()<CR>', {
    desc = "Toggle Spectre"
})
EOF

nnoremap <Leader>Q :Telescope quickfix<CR>
nnoremap <Leader>p :lua require'telescope_cfg'.workspace_files()<CR>
nnoremap <Leader>g :lua require'telescope_cfg'.project_files()<CR>
nnoremap <Leader>gB :Telescope git_branches<CR>
nnoremap <Leader>m :lua require'telescope_cfg'.symbol_doc_lookup()<CR>
nnoremap <Leader>M :Telescope lsp_workspace_symbols<CR>
nnoremap ; :Telescope buffers show_all_buffers=true<CR>
"nnoremap <C-;> :lua require'telescope_cfg'.fuz_buf()<CR>
nnoremap <Leader>; :lua require'telescope_cfg'.fuz_buf()<CR>
nnoremap <Leader>s :Telescope live_grep<CR>
nnoremap <Leader>S :lua require("telescope").extensions.dir.live_grep()<CR>
nnoremap <Leader>j :Telescope jumplist<CR>
nnoremap <Leader>a :lua require'telescope_cfg'.sessions_search()<CR>
nnoremap <leader>t :lua require'telescope_cfg'.search_all_files()<CR>
nnoremap <Leader>T :lua require("telescope").extensions.dir.find_files()<CR>
nnoremap <Leader>h :Telescope command_history<CR>
nnoremap <Leader>?? :Telescope help_tags<CR>
nnoremap <Leader>? :Telescope man_pages<CR>
nnoremap <Leader>' :Telescope marks<CR>
nnoremap <Leader>gc :lua require'telescope_cfg'.git_cbuf()<CR>
nnoremap <Leader>gC :lua require'telescope_cfg'.git_checkout()<CR>
nnoremap <Leader>gl :lua require'telescope_cfg'.git_log()<CR>
nnoremap <Leader># :lua require'telescope_cfg'.config_files()<CR>
" gs to preform ag serach on cursor word
nnoremap gs :Telescope grep_string<CR>
