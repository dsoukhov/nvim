" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin()
Plug 'sainnhe/gruvbox-material'
Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-rooter'
Plug 'mhinz/vim-startify', {'do':'git fetch origin pull/482/head:pr-482 && git checkout pr-482'}
Plug 'neovim/nvim-lspconfig'
Plug 'kabouzeid/nvim-lspinstall', {'branch':'main'}
Plug 'ray-x/lsp_signature.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim', {'branch':'main'}
Plug 'dsoukhov/lightline-bufferline'
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
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'rafamadriz/friendly-snippets', {'branch':'main'}
Plug 'phaazon/hop.nvim'
Plug 'chaoren/vim-wordmotion'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'hrsh7th/nvim-compe'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'Pocco81/DAPInstall.nvim', {'branch':'main'}
Plug 'nvim-telescope/telescope-dap.nvim'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'rcarriga/nvim-dap-ui'
Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'roxma/vim-hug-neovim-rpc'
call plug#end()

source $HOME/.config/nvim/base.vim
source $HOME/.config/nvim/motion_cfg.vim
source $HOME/.config/nvim/colorscheme.vim
source $HOME/.config/nvim/lsp.vim
source $HOME/.config/nvim/git_cfg.vim
source $HOME/.config/nvim/tree.vim
source $HOME/.config/nvim/sessions_cfg.vim
source $HOME/.config/nvim/snippets_cfg.vim
source $HOME/.config/nvim/pairs_cfg.vim
source $HOME/.config/nvim/lightline_cfg.vim
source $HOME/.config/nvim/searcher_cfg.vim
source $HOME/.config/nvim/dap.vim
source $HOME/.config/nvim/runner_cfg.vim
source $HOME/.config/nvim/searcher_cfg.vim
