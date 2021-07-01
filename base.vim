set encoding=utf-8
set modelines=1
" enable mouse support
set mouse=a
" enable 256 color support
set t_Co=256
set autoread
set clipboard=unnamedplus
set incsearch
"Line nums hybrid by default
set relativenumber
set number
" Spaces for tabs
set tabstop=2 softtabstop=2
set shiftwidth=2
" syntax highlighting
"syntax on
set expandtab
" disable line wrap
set nowrap
" set vertical mode when diff
set diffopt+=vertical
"column config
set signcolumn=auto:3
set isfname+=@-@
"set termguicolors
"set scroll offset
set scrolloff=6
" Better indenting
"set autoindent
"set smartindent
" Show extra whitespace
"set list listchars=tab:>·,trail:·,extends:>,precedes:< 
set list lcs=tab:¦·,trail:·,extends:>,precedes:< 
"set leader key to \
let g:mapleader='\'
" Disable unsaved buffer warning
set hidden
" Disable swap
set noswapfile
" set highlight search
set hlsearch
" set vertical col
set colorcolumn=80
highlight ColorColumn ctermbg=darkgrey guibg=darkgrey
set cmdheight=1 " only one line for commands
set shortmess+=c " don't need to press enter so often
" no comment on newline
au BufEnter * set fo-=c fo-=r fo-=o

" remap split navigations
nnoremap <C-j> <C-W><C-J>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-l> <C-W><C-L>
nnoremap <C-h> <C-W><C-H>

" Disable help
map <F1> <Nop>
map <F1> <Esc>

" Disable arrow keys
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

" Better indenting
vnoremap < <gv
vnoremap > >gv

" dir keys respect line wraps
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" <Shift-V>ds to remove trailing whitespace on line
map ds :s/\s*$//g<cr>:noh<cr>

" toggle spellcheck
nn <leader>` :setlocal spell! spell?<CR>
" turn spellcheck on for gitcommits
autocmd FileType gitcommit setlocal spell

" unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>

" replace current selection with buffer
vmap r "_dP
"" Search highlight color
hi Search cterm=NONE ctermfg=black ctermbg=yellow

augroup resume_edit_position
    autocmd!
    autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
        \ | execute "normal! g`\"zvzz"
        \ | endif
augroup END
