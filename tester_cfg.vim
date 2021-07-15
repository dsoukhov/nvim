let g:ultest_use_pty = 1

nmap ]u <Plug>(ultest-next-fail)
nmap [u <Plug>(ultest-prev-fail)

nmap <silent><F1> :lua require'telescope_cfg'.tester_templates()<CR>
nmap <silent><F2> :Ultest<CR>
nmap <silent><F3> :UltestDebug<CR>
nmap <silent><F4> :UltestAttach<CR>

nmap <leader>us :UltestSummary<CR>
nmap <leader>ux :UltestStop<CR>
nmap <leader>uX :UltestStopNarest<CR>
nmap <leader>un :UltestDebugNearest<CR>
