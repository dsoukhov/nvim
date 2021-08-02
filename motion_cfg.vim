lua << EOF
require'hop'.setup()
require'clipmenu-nvim'.setup({cache_dir = "/home/daniel/.cache/clipmenu.6.daniel"})
EOF
"word motion config
nmap f <cmd> lua require("hop").hint_char1({direction = require'hop.hint'.HintDirection.AFTER_CURSOR})<CR>
vmap f <cmd> lua require("hop").hint_char1({direction = require'hop.hint'.HintDirection.AFTER_CURSOR})<CR>
nmap F <cmd> lua require("hop").hint_char1({direction = require'hop.hint'.HintDirection.BEFORE_CURSOR})<CR>
vmap F <cmd> lua require("hop").hint_char1({direction = require'hop.hint'.HintDirection.BEFORE_CURSOR})<CR>
nmap <C-f> <cmd> lua require'hop'.hint_words()<CR>
vmap <C-f> <cmd> lua require'hop'.hint_words()<CR>
"C-'
nmap ^[[39;5u <cmd> lua require'hop'.hint_lines_skip_whitespace()<CR>
vmap ^[[39;5u <cmd> lua require'hop'.hint_lines_skip_whitespace()<CR>
"C-/
nmap  <cmd> lua require'hop'.hint_patterns()<CR>
vmap  <cmd> lua require'hop'.hint_patterns()<CR>

let g:wordmotion_nomap = 1
nmap w          <Plug>WordMotion_w
nmap b          <Plug>WordMotion_b
nmap e          <Plug>WordMotion_e
vmap w          <Plug>WordMotion_w
vmap b          <Plug>WordMotion_b
vmap e          <Plug>WordMotion_e
nmap aw         <Plug>WordMotion_aw
nmap iw         <Plug>WordMotion_iw
vmap aw         <Plug>WordMotion_aw
vmap iw         <Plug>WordMotion_iw
cmap <C-R><C-W> <Plug>WordMotion_<C-R><C-W>

"surround config
xmap ys <Plug>VSurround
xmap yS <Plug>VgSurround

"clipmenu-yank config
nnoremap <leader>y :lua require'clipmenu-nvim'.clipmenu_telescope_BC()<CR>
nnoremap <leader>Y :lua require'clipmenu-nvim'.clipmenu_telescope_AC()<CR>
nmap ]p :lua require'clipmenu-nvim'.clipmenu_yankring_cycle_forward()<CR>
nmap [p :lua require'clipmenu-nvim'.clipmenu_yankring_cycle_back()<CR>
