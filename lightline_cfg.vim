" Lightline and lightline-bufferline required
let g:lightline = {
  \ 'colorscheme': 'gruvbox_material',
  \ 'active': {
  \   'left': [['mode', 'paste'], ['workspace'], ['git_status']],
  \   'right': [['lineinfo'], ['percent'], ['gitlinechanges'], ['readonly', 'lsp_warnings',
  \     'lsp_errors']]
  \ },
  \ 'tabline': {
  \   'left': [ ['buffers'] ],
  \   'right': [ [] ]
  \ },
  \ 'component_expand': {
  \   'buffers': 'lightline#bufferline#buffers',
  \ },
  \ 'component_type': {
  \   'readonly': 'error',
  \   'buffers': 'tabsel'
  \ },
  \ 'component_function': {
  \   'workspace': 'LightlineWorkspace',
  \   'gitlinechanges': 'LightlineGitChanges',
  \   'git_status': 'LightlineGitStatus'
  \ }
\ }

function! LightlineWorkspace()
    return pathshorten(getcwd())
endfunction

function! LightlineLspWarnings()
  return
endfunction

function! LightlineLspErrors()
  return
endfunction

function! LightlineGitStatus()
    return FugitiveHead(7)
endfunction

function! LightlineGitChanges()
  if exists("b:gitsigns_status")
    return b:gitsigns_status
  endif
  return ''
endfunction

set showtabline=2
"let g:lightline#bufferline#filename_modifier = ':t'
let g:lightline#bufferline#show_number  = 2
let g:lightline#bufferline#shorten_path = 0
let g:lightline#bufferline#clickable = 1
let g:lightline#bufferline#filter_by_tabpage = 1
let g:lightline.component_raw = {'buffers': 1}

nmap <Leader>] :bn<CR>
nmap <Leader>[ :bp<CR>

nmap <Leader>1 <Plug>lightline#bufferline#go(1)<CR>
nmap <Leader>2 <Plug>lightline#bufferline#go(2)<CR>
nmap <Leader>3 <Plug>lightline#bufferline#go(3)<CR>
nmap <Leader>4 <Plug>lightline#bufferline#go(4)<CR>
nmap <Leader>5 <Plug>lightline#bufferline#go(5)<CR>
nmap <Leader>6 <Plug>lightline#bufferline#go(6)<CR>
nmap <Leader>7 <Plug>lightline#bufferline#go(7)<CR>
nmap <Leader>8 <Plug>lightline#bufferline#go(8)<CR>
nmap <Leader>9 <Plug>lightline#bufferline#go(9)<CR>
nmap <Leader>0 :e#<CR>

nmap <leader>c1 <plug>lightline#bufferline#delete(1)<CR>
nmap <leader>c2 <plug>lightline#bufferline#delete(2)<CR>
nmap <leader>c3 <plug>lightline#bufferline#delete(3)<CR>
nmap <leader>c4 <plug>lightline#bufferline#delete(4)<CR>
nmap <leader>c5 <plug>lightline#bufferline#delete(5)<CR>
nmap <leader>c6 <plug>lightline#bufferline#delete(6)<CR>
nmap <leader>c7 <plug>lightline#bufferline#delete(7)<CR>
nmap <leader>c8 <plug>lightline#bufferline#delete(8)<CR>
nmap <leader>c9 <plug>lightline#bufferline#delete(9)<CR>
nmap <Leader>c0 :bw!<CR>
