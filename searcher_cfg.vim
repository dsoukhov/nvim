" set telescope bindings

lua << EOF
-- close on single exit
local actions = require('telescope.actions')

require('telescope').setup{
  defaults = {
    scroll_strategy    = "cycle",
    selection_strategy = "reset",
    layout_strategy    = "flex",
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
EOF

noremap <Leader>q :Telescope quickfix<CR>
nnoremap <Leader>p :lua require'telescope_cfg'.workspace_files()<CR>
nnoremap <Leader>g :Telescope git_files<CR>
nnoremap <Leader>gB :Telescope git_branches<CR>
nnoremap <Leader>m :lua require'telescope_cfg'.symbol_doc_lookup()<CR>
nnoremap <Leader>M :Telescope lsp_workspace_symbols<CR>
nnoremap ; :Telescope buffers show_all_buffers=true<CR>
nnoremap ' :lua require'telescope_cfg'.fuz_buf()<CR>
nnoremap <Leader>s :Telescope live_grep<CR>
nnoremap <leader>T :lua require'telescope_cfg'.search_only_certain_files()<CR>
nnoremap <leader>t :lua require'telescope_cfg'.search_all_files()<CR>
nnoremap <Leader>h :Telescope command_history<CR>
nnoremap <Leader>?? :Telescope help_tags<CR>
nnoremap <Leader>? :Telescope man_pages<CR>
nnoremap <Leader>gc :lua require'telescope_cfg'.git_cbuf()<CR>
nnoremap <Leader>gl :lua require'telescope_cfg'.git_log()<CR>
nnoremap <Leader># :lua require'telescope_cfg'.config_files()<CR>
" ga to preform ag serach on cursor word
nnoremap ga :Telescope grep_string<CR>
