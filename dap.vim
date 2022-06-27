lua << EOF
local dap = require('dap')

dap.defaults.fallback.terminal_win_cmd = 'belowright 7split new | setlocal winfixheight | setlocal winfixwidth'
--dap.defaults.fallback.terminal_win_cmd = ':e new'

----DIInstall ccppr_vsc, python
local dap_install = require("dap-install")
local dbg_list = require("dap-install.api.debuggers").get_installed_debuggers()

dap_install.setup({
  installation_path = vim.fn.stdpath("data") .. "/dapinstall/",
})

for _, debugger in ipairs(dbg_list) do
  dap_install.config(debugger)
end
-- print(vim.inspect(dap.adapters))

-- dap_install default misses this cfg for cpptools (installed via ccppr_vsc)
dap.adapters.cpptools.id="cppdbg"

dap.listeners.before["event_terminated"]["plugins-dap"] = function(session, body)
  dap.repl.close()
end

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

  layouts = {
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
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
})

require("nvim-dap-virtual-text").setup {
    enabled = true,                     -- enable this plugin (the default)
    enabled_commands = true,            -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
    highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
    highlight_new_as_changed = false,   -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
    show_stop_reason = true,            -- show stop reason when stopped for exceptions
    commented = false,                  -- prefix virtual text with comment string
    -- experimental features:
    virt_text_pos = 'eol',              -- position of virtual text, see `:h nvim_buf_set_extmark()`
    all_frames = false,                 -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
    virt_lines = false,                 -- show virtual lines instead of virtual text (will flicker!)
    virt_text_win_col = nil             -- position the virtual text at a fixed window column (starting from the first text column) ,
                                        -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
}
EOF

" nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
nnoremap <silent> <F10> :lua require'dap_helper'.step_over_or_load_template()<CR>
nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
nnoremap <silent> <F5>  :lua require'dap_helper'.cont()<CR>
"S-F5
nnoremap <silent> <F17> :lua require'dap_helper'.reverse_continue_or_run_dap_templates()<CR>
nnoremap <silent> <F6> :lua require'telescope_cfg'.task_templates("Dap templates", "~/.config/nvim/templates/dap", ".dap.json" )<CR>
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

noremap <silent><leader>x :lua require'dap'.repl.close();require'dap'.disconnect();require'dap'.close();require'dapui'.close()<CR>:AsyncStop<CR>:silent! :bd! /bin/sh<CR>:silent! :bd! repl<CR>:ccl<CR>
