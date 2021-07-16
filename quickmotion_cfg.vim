lua << EOF
require'hop'.setup()
EOF
nmap <Leader>J :HopWord<CR>
nmap <Leader>j :HopChar1<CR>
nmap <Leader>l :HopLine<CR>
nmap <Leader>/ :HopPattern<CR>
