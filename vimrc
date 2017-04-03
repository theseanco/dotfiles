set nocompatible              " be iMproved, required
filetype on                  " required
syntax on
set number
set wildmode=longest,list,full "added by cole
set wildmenu "added by cole"
set ruler
set nu
set hidden
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
Plugin 'SirVer/ultisnips'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'scrooloose/nerdtree'
Plugin 'klen/python-mode'
Plugin 'myusuf3/numbers.vim' "plugin to handle relative numbering
Plugin 'scrooloose/syntastic'
Plugin 'Lokaltog/vim-easymotion' "the mad motion plugin
Plugin 'joeytwiddle/sexy_scroller.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" New markdown things
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
" vim saving
Plugin 'tpope/vim-obsession'
" supercollider(!!)
Plugin 'supercollider/scvim'
" javascript for p5.js
Plugin 'pangloss/vim-javascript'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" so ~/.scvimrc  "adds supercollider vimfile, on the guidance of Cole Ingraham
let &t_Co=256
colorscheme Tomorrow-Night

"SYNTASTIC OPTIONS
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:rainbow_active = 1
let g:airline#extensions#tabline#enabled = 1 "enabling some of airline to manage multiple buffers
let g:airline_powerline_fonts = 1 "powerline fonts option. How wonderful.
nnoremap <C-n> :bnext<CR> 
"works with airline to confirm multiple buffers.
map <C-i> <Plug>(easymotion-b)
map <C-o> <Plug>(easymotion-w)
"changing default easymotion mappings
hi Normal ctermbg=none
"transparent terminal
set laststatus=2
"statusline always on
let g:pymode_rope_lookup_project = 0
let g:pymode_doc = 0
let g:pymode_rope = 0
"a bunch of things to do word wrapping
:set wrap
:set linebreak
:set nolist  " list disables linebreak
"ultisnips things
"let g:UltiSnipsExpandTrigger="<C-s>"
"let g:UltiSnipsJumpForwardTrigger="<tab>"
"let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetsDir = "~/.vim/bundle/vim-snippets/UltiSnips"
let g:UltiSnipsEnableSnipMate=1
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-tab>"
let g:UltiSnipsJumpForwardTrigger="<c-l>"
let g:UltiSnipsJumpBackwardTrigger="<c-h>"
let g:airline_theme='base16_tomorrow'
let g:vim_markdown_folding_disabled = 1

" have tabs be 4 spaces not 8
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" spell checking from https://robots.thoughtbot.com/vim-spell-checking
autocmd BufRead,BufNewFile *.md setlocal spell spelllang=en_gb
