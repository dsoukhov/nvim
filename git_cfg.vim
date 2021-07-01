nmap <leader>gb :Git blame<CR>
nmap <leader>gj :diffget //3<CR>
nmap <leader>gf :diffget //2<CR>
nmap <leader>gd :Gdiff master<CR>

" don't autoclose fugitive buffers
autocmd BufReadPost fugitive://* set bufhidden=hide

let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '_'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change            = '~'

" disable line change nums
let g:signify_sign_show_count = 0
let g:signify_sign_show_text = 1

nmap ]g <plug>(signify-next-hunk)
nmap [g <plug>(signify-prev-hunk)
nmap ]G 9999[g
nmap [G 9999]g
