function! s:read_template_into_buffer(template)
  execute '0r ~/.config/nvim/ulttest/templates/'.a:template
endfunction
command! -bang -nargs=* LoadTesterTemplate call fzf#run({
          \   'source': 'ls -1 ~/.config/nvim/ulttest/templates',
          \   'down': 10,
          \   'sink': function('<sid>read_template_into_buffer')
          \ })

let g:ultest_use_pty = 1

nmap ]u <Plug>(ultest-next-fail)
nmap [u <Plug>(ultest-prev-fail)

nmap <silent><F1> :tabe .tester<CR>:LoadTesterTemplate<CR>
nmap <silent><F2> :Ultest<CR>
nmap <silent><F3> :UltestDebug<CR>
nmap <silent><F4> :UltestAttach<CR>

nmap <leader>us :UltestSummary<CR>
nmap <leader>ux :UltestStop<CR>
nmap <leader>uX :UltestStopNarest<CR>
nmap <leader>un :UltestDebugNearest<CR>
