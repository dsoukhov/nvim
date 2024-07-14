" set telescope bindings
lua << EOF
-- close on single exit
local actions = require('telescope.actions')

require('telescope').setup{
  extensions = {
    aerial = {
      show_nesting = {
        ["_"] = false,
        json = true,
        yaml = true,
      },
    },
  },
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
})
-- You probably also want to set a keymap to toggle aerial
vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")

local noremap_silent = { noremap = true, silent = true }

vim.keymap.set('n', '<Leader>q', function()
  local qf_exists = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      qf_exists = true
    end
  end
  if qf_exists == true then
    vim.cmd("cclose")
    return
  end
  if not vim.tbl_isempty(vim.fn.getqflist()) then
    vim.cmd("copen")
  end
end, noremap_silent)

local builtin = require "telescope.builtin"
vim.keymap.set("n", ";", builtin.buffers, noremap_silent)
vim.keymap.set("n", "<Leader>Q", builtin.quickfix, noremap_silent)

EOF

nnoremap <Leader>p :lua require'telescope_cfg'.workspace_files()<CR>
nnoremap <Leader>g :lua require'telescope_cfg'.project_files()<CR>
nnoremap <Leader>gB :Telescope git_branches<CR>
nnoremap <Leader>m :lua require("telescope").extensions.aerial.aerial()<CR>
nnoremap <Leader>M :Telescope lsp_workspace_symbols<CR>
nnoremap <Leader>o :Telescope oldfiles<CR>
nnoremap <Leader>; :lua require'telescope_cfg'.fuz_buf()<CR>
nnoremap <Leader>s :Telescope live_grep<CR>
nnoremap <Leader>S :lua require("telescope").extensions.dir.live_grep()<CR>
nnoremap <Leader>A :lua require'telescope_cfg'.sessions_search()<CR>
nnoremap <leader>t :lua require'telescope_cfg'.search_all_files()<CR>
nnoremap <Leader>T :lua require("telescope").extensions.dir.find_files()<CR>
nnoremap <Leader>: :Telescope command_history<CR>
nnoremap <Leader>?? :Telescope help_tags<CR>
nnoremap <Leader>? :Telescope man_pages<CR>
nnoremap <Leader>' :Telescope marks<CR>
nnoremap <Leader>gc :lua require'telescope_cfg'.git_cbuf()<CR>
nnoremap <Leader>gC :lua require'telescope_cfg'.git_checkout()<CR>
nnoremap <Leader>gl :lua require'telescope_cfg'.git_log()<CR>
nnoremap <Leader># :lua require'telescope_cfg'.config_files()<CR>
nnoremap gs :Telescope grep_string<CR>
