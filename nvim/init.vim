set shell=/bin/bash

call plug#begin('~/.vim/plugged')

" FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" complition
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" theme
Plug 'dracula/vim', { 'as': 'dracula' }

" GUI
Plug 'itchyny/lightline.vim'
Plug 'machakann/vim-highlightedyank'

" NERDtree
Plug 'preservim/nerdtree'

" hz
Plug 'sheerun/vim-polyglot'
Plug 'ludovicchabant/vim-gutentags'
Plug 'kristijanhusak/vim-js-file-import', {'do': 'npm install'}
Plug 'rstacruz/vim-closer'
Plug 'bagrat/vim-buffet'
Plug 'ryanoasis/vim-devicons'
Plug 'psliwka/vim-smoothie'
Plug 'https://github.com/AndrewRadev/splitjoin.vim.git'
Plug 'tyru/caw.vim'
Plug 'mattn/emmet-vim'

call plug#end()
let g:lightline = {
      \ 'colorscheme': 'darcula',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \   'cocstatus': 'coc#status'
      \ },
      \ }
colorscheme dracula

" numbers
set relativenumber " Relative line numbers
set number

set showcmd " Show (partial) command in status line.
set mouse=a " mouse usage
