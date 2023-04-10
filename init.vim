" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin()
Plug 'sainnhe/gruvbox-material'
Plug 'itchyny/lightline.vim'
Plug 'spywhere/lightline-lsp'
Plug 'notjedi/nvim-rooter.lua', {'branch':'main'}
Plug 'mhinz/vim-startify', {'do':'git fetch origin pull/482/head:pr-482 && git checkout pr-482'}
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim', { 'do': 'MasonUpdate' }
Plug 'williamboman/mason-lspconfig'
Plug 'ray-x/lsp_signature.nvim'
Plug 'machakann/vim-highlightedyank'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'windwp/nvim-autopairs'
Plug 'windwp/nvim-ts-autotag', {'branch':'main'}
Plug 'AndrewRadev/whitespaste.vim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim', {'branch':'main'}
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'JoosepAlviste/nvim-ts-context-commentstring', {'branch':'main'}
Plug 'tpope/vim-repeat'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'phaazon/hop.nvim'
Plug 'chaoren/vim-wordmotion'
Plug 'nvim-treesitter/nvim-treesitter', {'do': 'TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'SmiteshP/nvim-navic'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'rafamadriz/friendly-snippets', {'branch':'main'}
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'princejoogie/dir-telescope.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'nvim-telescope/telescope-dap.nvim'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'rcarriga/nvim-dap-ui'
Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'roxma/vim-hug-neovim-rpc'
call plug#end()

source $HOME/.config/nvim/base.vim
source $HOME/.config/nvim/copy_paste.vim
source $HOME/.config/nvim/motion_cfg.vim
source $HOME/.config/nvim/colorscheme.vim
source $HOME/.config/nvim/lsp.vim
source $HOME/.config/nvim/git_cfg.vim
source $HOME/.config/nvim/tree.vim
source $HOME/.config/nvim/pairs_cfg.vim
source $HOME/.config/nvim/lightline_cfg.vim
source $HOME/.config/nvim/searcher_cfg.vim
source $HOME/.config/nvim/sessions_cfg.vim
source $HOME/.config/nvim/dap.vim
source $HOME/.config/nvim/runner_cfg.vim
