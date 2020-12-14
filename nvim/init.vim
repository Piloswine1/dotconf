 call plug#begin('~/.vim/plugged')
 Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
 Plug 'junegunn/fzf.vim'
 Plug 'neoclide/coc.nvim', {'branch': 'release'}
 Plug 'dracula/vim', { 'as': 'dracula' }
 Plug 'itchyny/lightline.vim'
 "Plug 'ludovicchabant/vim-gutentags'
 Plug 'rstacruz/vim-closer'

 "clap
 Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }

 "NErDtree
 Plug 'preservim/nerdtree'

 "multiline
 Plug 'mg979/vim-visual-multi', {'branch': 'master'}

 "tabline
 Plug 'bagrat/vim-buffet'

 "icons
 Plug 'ryanoasis/vim-devicons'

 "langs
 Plug 'sheerun/vim-polyglot'

 "dashboard
 Plug 'glepnir/dashboard-nvim'

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

 "set mouse=a " mouse usage
 set clipboard=unnamedplus
 set guifont=Fira\ Code:h15
 set encoding=UTF-8

 "nerdTree maps
 "autocmd vimenter * NERDTree
 map <C-b> :NERDTreeToggle<CR>
