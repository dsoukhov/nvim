" Lightline and lightline-bufferline required
let g:lightline = {
  \ 'colorscheme': 'gruvbox_material',
  \ 'active': {
  \   'left': [['mode', 'paste'], ['workspace'], ['git_branch']],
  \   'right': [['lineinfo'], ['percent'], ['gitlinechanges'], ['readonly', 'lsp_warnings',
  \     'lsp_errors']]
  \ },
  \ 'tabline': {
  \   'left': [ ['buffers'] ],
  \   'right': [ [] ]
  \ },
  \ 'component_expand': {
  \   'buffers': 'lightline#bufferline#buffers',
  \   'git_branch': 'FugitiveHead'
  \ },
  \ 'component_type': {
  \   'readonly': 'error',
  \   'buffers': 'tabsel'
  \ },
  \ 'component_function': {
  \   'workspace': 'LightlineWorkspace',
  \   'gitlinechanges': 'LightlineGitChanges'
  \ }
\ }

function! LightlineWorkspace()
    return pathshorten(expand('%:p:h'))
endfunction

function! LightlineLspWarnings()
  return
endfunction

function! LightlineLspErrors()
  return
endfunction

function! LightlineGitChanges()
  return sy#repo#get_stats_decorated()
endfunction

set showtabline=2
let g:lightline#bufferline#filename_modifier = ':t'
let g:lightline#bufferline#show_number  = 2
let g:lightline#bufferline#shorten_path = 0
let g:lightline#bufferline#clickable = 1
let g:lightline.component_raw = {'buffers': 1}

nmap <Leader>] :bn<CR>
nmap <Leader>[ :bp<CR>

nmap <Leader>1 <Plug>lightline#bufferline#go(1)
nmap <Leader>2 <Plug>lightline#bufferline#go(2)
nmap <Leader>3 <Plug>lightline#bufferline#go(3)
nmap <Leader>4 <Plug>lightline#bufferline#go(4)
nmap <Leader>5 <Plug>lightline#bufferline#go(5)
nmap <Leader>6 <Plug>lightline#bufferline#go(6)
nmap <Leader>7 <Plug>lightline#bufferline#go(7)
nmap <Leader>8 <Plug>lightline#bufferline#go(8)
nmap <Leader>9 <Plug>lightline#bufferline#go(9)
nmap <Leader>0 :e#<CR>

nmap <leader>c1 <plug>lightline#bufferline#delete(1)
nmap <leader>c2 <plug>lightline#bufferline#delete(2)
nmap <leader>c3 <plug>lightline#bufferline#delete(3)
nmap <leader>c4 <plug>lightline#bufferline#delete(4)
nmap <leader>c5 <plug>lightline#bufferline#delete(5)
nmap <leader>c6 <plug>lightline#bufferline#delete(6)
nmap <leader>c7 <plug>lightline#bufferline#delete(7)
nmap <leader>c8 <plug>lightline#bufferline#delete(8)
nmap <leader>c9 <plug>lightline#bufferline#delete(9)
nmap <Leader>c0 :bw<CR>
