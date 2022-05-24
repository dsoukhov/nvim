" Lightline and lightline-bufferline required
let g:lightline = {
  \ 'colorscheme': 'gruvbox_material',
  \ 'active': {
  \   'left': [['mode', 'paste'], ['absolutepath', 'modified'], ['git_status'], ['gps']],
  \   'right': [['lineinfo'], ['percent'], ['gitlinechanges'], ['readonly'], ['linter_errors', 'linter_warnings', 'linter_infos', 'linter_hints']]
  \ },
  \ 'component_type': {
  \   'readonly': 'error',
  \   'linter_hints': 'right',
  \   'linter_infos': 'right',
  \   'linter_warnings': 'warning',
  \   'linter_errors': 'error',
  \   'linter_ok': 'right',
  \ },
  \ 'component_function': {
  \   'gps': 'NvimGps',
  \   'workspace': 'LightlineWorkspace',
  \   'gitlinechanges': 'LightlineGitChanges',
  \   'git_status': 'LightlineGitStatus',
  \   'linter_hints': 'lightline#lsp#hints',
  \   'linter_infos': 'lightline#lsp#infos',
  \   'linter_warnings': 'lightline#lsp#warnings',
  \   'linter_errors': 'lightline#lsp#errors',
  \   'linter_ok': 'lightline#lsp#ok',
  \ }
\ }

func! NvimGps() abort
  return luaeval("require'nvim-gps'.is_available()") ?
    \ luaeval("require'nvim-gps'.get_location()") : ''
endf

function! LightlineWorkspace()
    return pathshorten(getcwd())
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
