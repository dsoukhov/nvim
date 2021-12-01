set encoding=utf-8
set modelines=1
" enable mouse support
set mouse=a
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
set ignorecase
set smartcase
" set vertical col
set colorcolumn=80
set cursorline
set cmdheight=1 " only one line for commands
set shortmess+=c " don't need to press enter so often
" no comment on newline
au BufEnter * set fo-=c fo-=r fo-=o

" follow view of cursor
set sidescrolloff=999
set scrolloff=999

set splitright
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

"set undodir
let s:undodir = "/tmp/.undodir_" . $USER
if !isdirectory(s:undodir)
    call mkdir(s:undodir, "", 0700)
endif
let &undodir=s:undodir
set undofile

" Better indenting
vnoremap < <gv
vnoremap > >gv

" +/- to increment/dec
nnoremap + <C-a>
nnoremap - <C-x>

" dot repeat visual sel
xnoremap . :norm.<CR>

" dir keys respect line wraps
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" <Shift-V>ds to remove trailing whitespace on line
map ds :s/\s*$//g<cr>:noh<cr>

nnoremap Y y$
nnoremap gy gg"+yG
" make change ops go to black hole
nnoremap c "_c
nnoremap C "_C

" execute q reg macro over selection
xnoremap Q :'<,'>:normal @q<CR>

" move text
vnoremap K :m '<-2<CR>gv=gv
vnoremap J :m '>+1<CR>gv=gv

" map relevant st termkeys for use in vim
map ^[[39;5u <C-'>
map  <C-\>
map ^[[70;6u <C-S-F>
map ^[[59;5u <C-;>

" toggle spellcheck
nn <leader>` :setlocal spell! spell?<CR>
" turn spellcheck on for gitcommits
autocmd FileType gitcommit setlocal spell

" unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>

" replace current selection with buffer
vmap r "_dP

" map select last pasted as gp
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
