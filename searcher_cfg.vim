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

require("aerial").setup({
  layout = {
    default_direction = "prefer_left",
  },
  -- optionally use on_attach to set keymaps when aerial has attached to a buffer
  on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
    vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
    vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
  end,
})
-- You probably also want to set a keymap to toggle aerial
vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle<CR>")
EOF

nnoremap <silent> <Leader>Q :Telescope quickfix<CR>
nnoremap <silent> <Leader>p :lua require'telescope_cfg'.workspace_files()<CR>
nnoremap <silent> <Leader>g :lua require'telescope_cfg'.project_files()<CR>
nnoremap <silent> <Leader>gB :Telescope git_branches<CR>
nnoremap <silent> <Leader>m :lua require'telescope_cfg'.symbol_doc_lookup()<CR>
nnoremap <silent> <Leader>M :Telescope lsp_workspace_symbols<CR>
nnoremap <silent> ; :Telescope buffers<CR>
nnoremap <silent> <Leader>o :Telescope oldfiles<CR>
"nnoremap <silent>  <C-;> :lua require'telescope_cfg'.fuz_buf()<CR>
nnoremap <silent> <Leader>; :lua require'telescope_cfg'.fuz_buf()<CR>
nnoremap <silent> <Leader>s :Telescope live_grep<CR>
nnoremap <silent> <Leader>S :lua require("telescope").extensions.dir.live_grep()<CR>
nnoremap <silent> <Leader>j :Telescope jumplist<CR>
nnoremap <silent> <Leader>A :lua require'telescope_cfg'.sessions_search()<CR>
nnoremap <silent> <leader>t :lua require'telescope_cfg'.search_all_files()<CR>
nnoremap <silent> <Leader>T :lua require("telescope").extensions.dir.find_files()<CR>
nnoremap <silent> <Leader>h :Telescope command_history<CR>
nnoremap <silent> <Leader>?? :Telescope help_tags<CR>
nnoremap <silent> <Leader>? :Telescope man_pages<CR>
nnoremap <silent> <Leader>' :Telescope marks<CR>
nnoremap <silent> <Leader>gc :lua require'telescope_cfg'.git_cbuf()<CR>
nnoremap <silent> <Leader>gC :lua require'telescope_cfg'.git_checkout()<CR>
nnoremap <silent> <Leader>gl :lua require'telescope_cfg'.git_log()<CR>
nnoremap <silent> <Leader># :lua require'telescope_cfg'.config_files()<CR>
" gs to preform ag serach on cursor word
nnoremap <silent> gs :Telescope grep_string<CR>
