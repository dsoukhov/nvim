map p <Plug>(miniyank-autoput)
map P <Plug>(miniyank-autoPut)
"map <leader>p <Plug>(miniyank-startput)
"map <leader>P <Plug>(miniyank-startPut)
map ]y <Plug>(miniyank-cycle)
map [y <Plug>(miniyank-cycleback)
let g:miniyank_maxitems = 50

nnoremap <leader>y :lua require'telescope_cfg'.yanks(false)<CR>
nnoremap <leader>Y :lua require'telescope_cfg'.yanks(true)<CR>
