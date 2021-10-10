lua << EOF
local dap = require('dap')
local dap_adapters = vim.fn.stdpath("data") .. "/dapinstall/"

-- dap.defaults.fallback.terminal_win_cmd = ':belowright 7split new'
dap.defaults.fallback.terminal_win_cmd = ':e new'

--DIInstall ccppr_vsc_dbg, python_dbg, go_delve_dbg, jsnode_dbg, java_dbg
dap.adapters.vsc_ccppr = {
  type = 'executable',
  command = dap_adapters .. "ccppr_vsc_dbg/extension/debugAdapters/OpenDebugAD7"
}

dap.adapters.python = {
  type = 'executable';
  --command = 'python';
  command = dap_adapters .. "python_dbg/bin/python",
  args = { '-m', 'debugpy.adapter' };
}

require('telescope').load_extension('dap')

require("dapui").setup({
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
  },
  sidebar = {
    -- You can change the order of elements in the sidebar
    elements = {
      -- Provide as ID strings or tables with "id" and "size" keys
      {
        id = "scopes",
        size = 0.25, -- Can be float or integer > 1
      },
      { id = "breakpoints", size = 0.25 },
      { id = "stacks", size = 0.25 },
      { id = "watches", size = 00.25 },
    },
    size = 40,
    position = "left", -- Can be "left", "right", "top", "bottom"
  },
  tray = {},
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
})

EOF

nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
nnoremap <silent> <F5>  :lua require'dap_helper'.cont()<CR>
"S-F5
nnoremap <silent> <F17> :lua require'dap'.reverse-continue()<CR>
nnoremap <silent> <F17> :lua require'dap'.close()<CR>
nnoremap <silent> <F6> :lua require'telescope_cfg'.dap_templates()<CR>
nnoremap <leader>dh :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <leader>dj :lua require'dap'.down()<CR>
nnoremap <leader>dk :lua require'dap'.up()<CR>
nnoremap <leader>dg :lua require'dap'.goto_()<CR>
nnoremap <leader>dH :lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>
nnoremap <leader>de :lua require'dap'.set_exception_breakpoints({"all"})<CR>
nnoremap <leader>d_ :lua require'dap'.disconnect();require'dap'.stop();require'dap'.run_last()<CR>
nnoremap <leader>dr :lua require'dap_helper'.repl_tog()<CR><C-w>l
nnoremap <leader>dK :lua require("dapui").eval()<CR>
vnoremap <leader>dK :lua require("dapui").eval()<CR>
nnoremap <leader>ds :lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>
nnoremap <leader>da :lua require'dap_helper'.attach()<CR>
nnoremap <leader>dt :lua require'dap'.threads()<CR>

nnoremap <leader>df :Telescope dap frames<CR>
nnoremap <leader>db :Telescope dap list_breakpoints<CR>
nnoremap <leader>du :lua require'dapui'.toggle()<CR>

"dap virtual text
let g:dap_virtual_text = 'true'
let g:dap_virtual_text_commented = v:true
