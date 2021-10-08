let g:asynctasks_extra_config = [ '~/.config/nvim/async-tasks/default.ini' ]
"run external term
"let g:asynctasks_term_pos = 'external'
let g:asyncrun_rootmarks = ['.git', '.svn', '.root', '.project', '.hg']
let g:asyncrun_open = 6

noremap <silent><F7> :AsyncTask project-run<cr>
noremap <silent><F8> :lua require('telescope_cfg').runner_templates()<CR>
noremap <silent><F9> :call Projbuild()<CR>
"shift+F7
noremap <silent><F19> :lua require('telescope_cfg').runner_configs()<CR>
"shift+F9
noremap <silent><F21> :lua require('telescope_cfg').runner_configs()<CR>

noremap <silent><F1> :lua require('telescope_cfg').tester_templates()<CR>
noremap <silent><F2> :AsyncTask test-run<CR>
noremap <silent><F3> :AsyncTask test-debug<CR>
noremap <silent><F4> :AsyncTask test-attach<CR>
noremap <silent><leader>x :lua require'dap'.repl.close();require'dap'.disconnect();require'dap'.close();<CR>:AsyncStop<CR>:silent! :bd! /bin/sh<CR>:silent! :bd! repl<CR>:ccl<CR>

"prevent infinte reloading of Projbuild
if exists('*Projbuild')
    finish
endif
" source + reload lua/vim files and build all others
function! Projbuild()
  :silent! write
  :let g:mod = expand("%:t:r")
  if &filetype == 'vim'
    :source %
    :echo g:mod . " reloaded"
  elseif &filetype == 'lua'
    :lua require("plenary.reload").reload_module(vim.g.mod)
    :luafile %
    :echo g:mod . " reloaded"
  else
    :AsyncTask project-build
  endif
  return
endfunction
