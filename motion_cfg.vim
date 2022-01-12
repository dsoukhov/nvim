lua << EOF
require'hop'.setup()
EOF
"word motion config
nmap f <cmd> lua require("hop").hint_char1({direction = require'hop.hint'.HintDirection.AFTER_CURSOR})<CR>
vmap f <cmd> lua require("hop").hint_char1({direction = require'hop.hint'.HintDirection.AFTER_CURSOR})<CR>
nmap F <cmd> lua require("hop").hint_char1({direction = require'hop.hint'.HintDirection.BEFORE_CURSOR})<CR>
vmap F <cmd> lua require("hop").hint_char1({direction = require'hop.hint'.HintDirection.BEFORE_CURSOR})<CR>
nmap <C-f> <cmd> lua require'hop'.hint_words({direction = require'hop.hint'.HintDirection.AFTER_CURSOR})<CR>
vmap <C-f> <cmd> lua require'hop'.hint_words({direction = require'hop.hint'.HintDirection.AFTER_CURSOR})<CR>
nmap <C-S-F> <cmd> lua require'hop'.hint_words({direction = require'hop.hint'.HintDirection.BEFORE_CURSOR})<CR>
vmap <C-S-F> <cmd> lua require'hop'.hint_words({direction = require'hop.hint'.HintDirection.BEFORE_CURSOR})<CR>
nmap <C-'> <cmd> lua require'hop'.hint_lines_skip_whitespace()<CR>
vmap <C-'> <cmd> lua require'hop'.hint_lines_skip_whitespace()<CR>
map <C-\> <cmd> lua require'hop'.hint_patterns()<CR>
vmap <C-\> <cmd> lua require'hop'.hint_patterns()<CR>

let g:wordmotion_nomap = 1
let g:wordmotion_extra = ['^#define\>', '^#ifdef\>']

nmap w          <Plug>WordMotion_w
nmap b          <Plug>WordMotion_b
nmap e          <Plug>WordMotion_e
vmap w          <Plug>WordMotion_w
vmap b          <Plug>WordMotion_b
vmap e          <Plug>WordMotion_e
omap w          <Plug>WordMotion_w
omap b          <Plug>WordMotion_b
omap e          <Plug>WordMotion_e
omap aw         <Plug>WordMotion_aw
omap iw         <Plug>WordMotion_iw
vmap aw         <Plug>WordMotion_aw
vmap iw         <Plug>WordMotion_iw
cmap <C-R><C-W> <Plug>WordMotion_<C-R><C-W>

"surround config
xmap ys <Plug>VSurround
xmap yS <Plug>VgSurround
