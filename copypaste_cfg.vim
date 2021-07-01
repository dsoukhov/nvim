map p <Plug>(miniyank-autoput)
map P <Plug>(miniyank-autoPut)
"map <leader>p <Plug>(miniyank-startput)
"map <leader>P <Plug>(miniyank-startPut)
map ]p <Plug>(miniyank-cycle)
map [p <Plug>(miniyank-cycleback)
let g:miniyank_maxitems = 50

function! s:fzf_miniyank(put_before, fullscreen) abort
    function! Sink(opt, line) abort
        let l:key = substitute(a:line, ' .*', '', '')
        if empty(a:line) | return | endif
        let l:yanks = miniyank#read()[l:key]
        call miniyank#drop(l:yanks, a:opt)
    endfunction

    let l:put_action = a:put_before ? 'P' : 'p'
    let l:name = a:put_before ? 'YanksBefore' : 'YanksAfter'
    let l:spec = {}
    let l:spec['source'] = map(miniyank#read(), {k,v -> k.' '.join(v[0], '\n')})
    let l:spec['sink'] = {val -> Sink(l:put_action, val)}
    let l:spec['options'] = '--no-sort --prompt="Yanks-'.l:put_action.'> "'
    call fzf#run(fzf#wrap(l:name, l:spec, a:fullscreen))
endfunction

command! -bang YanksBefore call s:fzf_miniyank(1, <bang>0)
command! -bang YanksAfter call s:fzf_miniyank(0, <bang>0)

nnoremap <leader>y :lua require'telescope_cfg'.yanks(false)<CR>
nnoremap <leader>Y :lua require'telescope_cfg'.yanks(true)<CR>
