call plug#begin()
Plug 'sainnhe/gruvbox-material'
Plug 'itchyny/lightline.vim'
Plug 'dsoukhov/lightline-bufferline'
Plug 'lambdalisue/suda.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'bfredl/nvim-miniyank'
Plug 'mbbill/undotree'
Plug 'Yggdroot/indentLine'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'JoosepAlviste/nvim-ts-context-commentstring', {'branch':'main'}
Plug 'tpope/vim-commentary'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'rafamadriz/friendly-snippets'
Plug 'easymotion/vim-easymotion'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'ahmedkhalf/lsp-rooter.nvim', {'branch':'main'}
Plug 'neovim/nvim-lspconfig'
Plug 'kabouzeid/nvim-lspinstall', {'branch':'main'}
Plug 'hrsh7th/nvim-compe'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'Pocco81/DAPInstall.nvim', {'branch':'main'}
Plug 'nvim-telescope/telescope-dap.nvim'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'nvim-telescope/telescope-dap.nvim'
Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'mhinz/vim-startify'
Plug 'janko/vim-test'
Plug 'rcarriga/vim-ultest', { 'do': ':UpdateRemotePlugins' }
call plug#end()

source $HOME/.config/nvim/base.vim
source $HOME/.config/nvim/colorscheme.vim
source $HOME/.config/nvim/tree.vim
source $HOME/.config/nvim/sessions_cfg.vim
source $HOME/.config/nvim/snippets_cfg.vim
source $HOME/.config/nvim/quickmotion_cfg.vim
source $HOME/.config/nvim/copypaste_cfg.vim
source $HOME/.config/nvim/undotree_cfg.vim
source $HOME/.config/nvim/lightline_cfg.vim
source $HOME/.config/nvim/searcher_cfg.vim
source $HOME/.config/nvim/git_cfg.vim
source $HOME/.config/nvim/lsp.vim
source $HOME/.config/nvim/dap.vim
source $HOME/.config/nvim/runner_cfg.vim
source $HOME/.config/nvim/tester_cfg.vim
