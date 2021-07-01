lua << EOF
local dap = require('dap')
local dap_adapters = vim.fn.stdpath("data") .. "/dapinstall/"

dap.defaults.fallback.terminal_win_cmd = ':belowright 7split new'

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

EOF

nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
nnoremap <silent> <F5>  :lua require'dap_helper'.cont()<CR>
nnoremap <silent> <F6> :lua require'telescope_cfg'.dap_templates()<CR>
nnoremap <leader>dh :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <leader>dH :lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>
nnoremap <leader>de :lua require'dap'.set_exception_breakpoints({"all"})<CR>
nnoremap <leader>d_ :lua require'dap'.run_last()<CR>
nnoremap <leader>dr :lua require'dap'.repl.toggle({}, ':belowright vsp')<CR><C-w>l
nnoremap <leader>dk :lua require'dap.ui.variables'.hover(function () return vim.fn.expand("<cexpr>") end)<CR>
vnoremap <leader>dk :lua require'dap.ui.variables'.visual_hover()<CR>
nnoremap <leader>ds :lua require'dap.ui.variables'.scopes()<CR>
nnoremap <leader>da :lua require'dap_helper'.attach()<CR>
nnoremap <leader>dx :lua require'dap'.repl.close()<CR>:lua require'dap'.disconnect()<CR>:AsyncStop<CR>:bd! term<CR>

lua << EOF
require('telescope').setup()
require('telescope').load_extension('dap')
EOF
nnoremap <leader>df :Telescope dap frames<CR>
nnoremap <leader>dc :Telescope dap commands<CR>
nnoremap <leader>db :Telescope dap list_breakpoints<CR>
nnoremap <leader>dv :Telescope dap variables<CR>

"dap virtal text
"let g:dap_virtual_text = 'true'
let g:dap_virtual_text = 'all frames'
