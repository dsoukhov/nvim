lua << EOF
require'hop'.setup()
--word motion config
local hop = require('hop')
local directions = require('hop.hint').HintDirection
vim.keymap.set('', 'f', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true})
end, {remap=true})
vim.keymap.set('', 'F', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true})
end, {remap=true})
vim.keymap.set('', 't', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
end, {remap=true})
vim.keymap.set('', 'T', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = -1 })
end, {remap=true})
vim.keymap.set('', '<C-f>', function()
  hop.hint_words({ direction = directions.AFTER_CURSOR})
end, {remap=true})
vim.keymap.set('', '<C-S-F>', function()
  hop.hint_words({ direction = directions.BEFORE_CURSOR})
end, {remap=true})
vim.keymap.set('', '<C-\'>', function()
  hop.hint_lines_skip_whitespace()
end, {remap=true})
vim.keymap.set('', '<C-\\>', function()
  hop.hint_patterns()
end, {remap=true})
EOF

if match(&runtimepath, 'vim-wordmotion') != -1
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

endif

"surround config
xmap ys <Plug>VSurround
xmap yS <Plug>VgSurround
