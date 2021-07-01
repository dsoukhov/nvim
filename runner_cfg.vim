let g:asynctasks_extra_config = [ '~/.config/nvim/async-tasks/default.ini' ]
"run external term
"let g:asynctasks_term_pos = 'external'
let g:asyncrun_rootmarks = ['.git', '.svn', '.root', '.project', '.hg']
let g:asyncrun_open = 6

noremap <silent><F7> :AsyncTask project-run<cr>
nnoremap <silent><F8> :lua require('telescope_cfg').runner_templates()<CR>
noremap <silent><F9> :AsyncTask project-build<cr>

"shift+F7
noremap <silent><F19> :AsyncTask file-run<cr>
"shift+F9
noremap <silent><F21> :AsyncTask file-build<cr>
