lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  context_commentstring = {
    enable = true
  },
  ignore_install = {}, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = {},  -- list of language that will be disabled
  },
  indent = {
    enable = true
  },
  autotag = {
    enable = true
  }
}
EOF

" set foldmethod=expr
" setlocal foldlevelstart=99
" set foldexpr=nvim_treesitter#foldexpr()

nmap <Leader>tr :write \| edit \| TSBufEnable highlight<CR>
