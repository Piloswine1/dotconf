 call plug#begin('~/.vim/plugged')
 Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
 Plug 'junegunn/fzf.vim'
 Plug 'mcchrish/nnn.vim'
 "Plug 'neoclide/coc.nvim', {'branch': 'release'}
 Plug 'dracula/vim', { 'as': 'dracula' }
 Plug 'itchyny/lightline.vim'
 "Plug 'ludovicchabant/vim-gutentags'
 Plug 'rstacruz/vim-closer'

 "LSP
 Plug 'autozimu/LanguageClient-neovim', {
 	\ 'branch': 'next',
   	\ 'do': 'bash install.sh',
 	\ }
 "Complition
 if has('nvim')
   Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
 else
   Plug 'Shougo/deoplete.nvim'
   Plug 'roxma/nvim-yarp'
   Plug 'roxma/vim-hug-neovim-rpc'
 endif

 "clap
 Plug 'liuchengxu/vim-clap', { 'do': { -> clap#installer#force_download() } }

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

 " Floating window
let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Debug' } }

 let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'cpp': ['clangd'],
    \ }

 let g:deoplete#enable_at_startup = 1

 " LSP mappings
 nmap <F5> <Plug>(lcn-menu)

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
