" TODO:
" - JSX syntax highlighting
" - Look at old vim config and bring across relevant settings
" - Ignore node modules on fzf
" - Colorschemes
" - Customise Powerline
" - Git integration

call plug#begin("~/.vim/plugged")
" File tree and icons
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
" color scheme install
Plug 'dracula/vim'
" fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" COC
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = ['coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-tsserver', 'coc-eslint']
" airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Fugitive, git integration
Plug 'tpope/vim-fugitive'
" Gitgutter, for seeing info about github changes
Plug 'airblade/vim-gitgutter'
call plug#end()

"Config Section

"Color scheme code
if (has("termguicolors"))
 set termguicolors
endif
syntax enable
colorscheme dracula

" Control NERDTree
" Following is useful for working with nerdtree
" https://cheatography.com/stepk/cheat-sheets/vim-nerdtree/
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Toggle
nnoremap <silent> <C-a> :NERDTreeToggle<CR>

" open new split panes to right and below
set splitright
set splitbelow
" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>
" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" open terminal on ctrl+n
function! OpenTerminal()
  split term://zsh
  resize 10
endfunction
nnoremap <c-n> :call OpenTerminal()<CR>

" use alt+hjkl to move between split/vsplit panels
" Mapped to relevant alt mac keystrokes
tnoremap ˙ <C-\><C-n><C-w>h
tnoremap ∆ <C-\><C-n><C-w>j
tnoremap ˚ <C-\><C-n><C-w>k
tnoremap ¬ <C-\><C-n><C-w>l
nnoremap ˙ <C-w>h
nnoremap ∆ <C-w>j
nnoremap ˚ <C-w>k
nnoremap ¬ <C-w>l

" Reloads vimrc after saving but keep cursor position
if !exists('*ReloadVimrc')
   fun! ReloadVimrc()
       let save_cursor = getcurpos()
       source $MYVIMRC
       call setpos('.', save_cursor)
   endfun
endif
autocmd! BufWritePost $MYVIMRC call ReloadVimrc()

" Activate fuzzy finder
nnoremap <C-p> :FZF<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}

" Use silver searcher to ignore node files
" Not entirely sure this works
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" Relative Line numbering
set number relativenumber

" Tabs as two spaces
set expandtab
set tabstop=2

" Enable mac clipboard
set clipboard=unnamed

" Updatetime enables gitgutter diffs to come up faster
set updatetime=100

" Experimental prettier config
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" airline fonts
let g:airline_powerline_fonts = 1

" experimental tabstop calculation https://stackoverflow.com/questions/14173766/vim-ignores-shiftwidth-specified-in-vimrc
set expandtab " Make sure that every file uses real tabs, not spaces
set shiftround  " Round indent to multiple of 'shiftwidth'
set smartindent " Do smart indenting when starting a new line
set autoindent  " Copy indent from current line, over to the new line

" Set the tab width
let s:tabwidth=2
exec 'set tabstop='    .s:tabwidth
exec 'set shiftwidth=' .s:tabwidth
exec 'set softtabstop='.s:tabwidth



" What can I do?
" - Ctrl+a to toggle file explorer
" - vimrc autoreloads when edited
" - devicons can set icons for file tree, may need nerdfonts
" - Font icons can be downloaded from here https://github.com/ryanoasis/nerd-fonts/releases/tag/v2.1.0
" - ctrl + n opens new terminal (zsh)
" - Alt+HJKL switch between terminals, mapped properly
" - Ctrl+P for fuzzy finding
"   - Then:
"   	- CTRL+T for new tab
"   	- CTRL+S for open below split
"   	- CTRL+V for open side split
"   	- ENTER for open in current tab
" - Node modules is ignored using the silver searcher
" - Tabs are two spaces
" - Relative numbering
" - Uses osx clipboard
" - COC prettier has been installed, there is some autocomplete stuff in there


" things to remember
" g t / g T switches tabs
