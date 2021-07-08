"requires gruvbox_material
set background=dark
"set gruvbox theme if terminal permits
if exists('+termguicolors')
  let &t_8f =  "\<Esc>[38:2:%lu:%lu:%lum"
  let &t_8b =  "\<Esc>[48:2:%lu:%lu:%lum"
  set t_Co=256
  let g:gruvbox_material_background = 'hard'
  let g:gruvbox_material_diagnostic_virtual_text = 'color'
  let g:gruvbox_material_diagnostic_text_highlight = 1
  "let g:gruvbox_material_background = 'medium'
  colorscheme gruvbox-material
  set termguicolors
endif

"enable colorizer
lua require'colorizer'.setup()
