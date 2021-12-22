lua << EOF
require'clipmenu-nvim'.setup({cache_dir = "/home/daniel/.cache/clipmenu.6.daniel"})
EOF

"clipmenu-yank config
nmap <leader>y :lua require'clipmenu-nvim'.clipmenu_telescope_BC()<CR>
nmap <leader>Y :lua require'clipmenu-nvim'.clipmenu_telescope_AC()<CR>
vmap <leader>y :lua require'clipmenu-nvim'.clipmenu_telescope_VM()<CR>
vmap <leader>Y :lua require'clipmenu-nvim'.clipmenu_telescope_VM()<CR>
nmap ]p :lua require'clipmenu-nvim'.clipmenu_yankring_cycle_forward()<CR>
nmap [p :lua require'clipmenu-nvim'.clipmenu_yankring_cycle_back()<CR>
