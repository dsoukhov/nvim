let g:asynctasks_extra_config = [ '~/.config/nvim/async-tasks/default.ini' ]
"run external term
"let g:asynctasks_term_pos = 'external'
let g:asyncrun_rootmarks = ['.git', '.svn', '.root', '.project', '.hg']
let g:asyncrun_open = 6

noremap <silent><F1> :AsyncTask run-test<CR>
noremap <silent><F2> :lua require('telescope_cfg').task_templates("Tester templates", "~/.config/nvim/templates/test", ".tasks")<CR>
"Shift+F2
noremap <silent><F14> :lua require('telescope_cfg').runner_configs()<CR>
noremap <silent><F3> :AsyncTask debug-test<CR>
noremap <silent><F4> :AsyncTask attach-test<CR>
noremap <silent><F7> :AsyncTask project-run<cr>
"shift+F7
noremap <silent><F19> :lua require('telescope_cfg').runner_configs()<CR>
noremap <silent><F8> :lua require('telescope_cfg').task_templates("Runner templates", "~/.config/nvim/templates/run", ".tasks")<CR>
noremap <silent><F9> :call Projbuild()<CR>
"shift+F9
noremap <silent><F21> :lua require('telescope_cfg').runner_configs()<CR>

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
