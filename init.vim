" TODO:
" - JSX syntax highlighting
" - Colorschemes
" - Customise Powerline
" - Git integration

call plug#begin("~/.vim/plugged")
" File tree and icons
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
" NERDTree github integration
Plug 'Xuyuanp/nerdtree-git-plugin'
" color scheme install
Plug 'dracula/vim'
Plug 'gryf/wombat256grf'
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
" Auto bracket completion
Plug 'jiangmiao/auto-pairs'
" Better JSX
Plug 'MaxMEllon/vim-jsx-pretty'
" Gruvbox - full-featured color scheme
Plug 'morhetz/gruvbox'
" Ack - for searching
Plug 'mileszs/ack.vim'
Plug 'APZelos/blamer.nvim'
" Nice colour schemes
Plug 'chriskempson/base16-vim'
" Typescript support
Plug 'leafgarland/typescript-vim'
" Tab renamer with TabooRename
Plug 'gcmt/taboo.vim'
" vim javascript stuff
Plug 'pangloss/vim-javascript'
" Prettier plugin for vim
" Plug 'sbdchd/neoformat'
" Plugin for styled JSX
Plug 'alampros/vim-styled-jsx'
" Barbar for better top bar
" Plug 'kyazdani42/nvim-web-devicons'
" Plug 'romgrk/barbar.nvim'
" Treesitter, works really nicely
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
" coloriser Works really nicely
Plug 'norcalli/nvim-colorizer.lua'
" Neon theme for Neovim, don't like it
" Plug 'rafamadriz/neon'
Plug 'sainnhe/gruvbox-material'
" Pug templates
Plug 'digitaltoad/vim-pug'
call plug#end()

"Config Section

"Color scheme code
if (has("termguicolors"))
 set termguicolors
endif
syntax enable
" NOT SURE IF THIS WORKS
" let g:gruvbox_italic=1

" New material gruvbox fun styling
let g:gruvbox_material_enable_italic = 1
set background=dark



" Dark theme
colorscheme gruvbox
" Light theme
" colorscheme zellner
" Neon theme for treesitter
" let g:gruvbox_material_palette = 'original'
" colorscheme gruvbox-material
"Control NERDTree
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

"option plus f to open Rg, for fuzzy file searching
nnoremap ƒ :Rg<CR>


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
" let $FZF_DEFAULT_COMMAND = 'ag -g ""'

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
" airline color scheme
let g:airline_theme = 'gruvbox_material'

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

" add gitlens by default
let g:blamer_enabled = 1

" show max line length for inflowmatix react code
" set colorcolumn=80

" Mappings to go to type definitions/implementation/references, taken from https://pragmaticpineapple.com/ultimate-vim-typescript-setup/
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Prettier format on save
" autocmd BufWritePre *.ts Neoformat
" autocmd BufWritePre *.tsx Neoformat
" Prettier format on save
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

" Open fzf in split
let g:fzf_layout = { 'down': '~35%' }

" Treesitter dialog, taken straight from their readme
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "c", "rust" },  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF

" start colorizer
lua require'colorizer'.setup()

" Italic support
set t_ZH=^[[3m
set t_ZR=^[[23m

" NerdTreeFind shortcut
command NF :NERDTreeFind

" Neon colorscheme config
"lua <<EOF
"  vim.g.neon_style = "dark"
"  vim.g.neon_italic_keyword = true
"  vim.g.neon_italic_function = true
"  vim.g.neon_italic_variable = true

"  vim.cmd[[colorscheme neon]]
"EOF

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
