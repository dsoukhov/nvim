" Lightline and lightline-bufferline required
let g:lightline = {
  \ 'colorscheme': 'gruvbox_material',
  \ 'active': {
  \   'left': [['mode', 'paste'], ['absolutepath', 'modified'], ['git_status']],
  \   'right': [['lineinfo'], ['percent'], ['gitlinechanges'], ['readonly', 'lsp_warnings',
  \     'lsp_errors']]
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
