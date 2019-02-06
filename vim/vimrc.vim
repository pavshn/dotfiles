" This must be first, because it changes other options
if &compatible
  set nocompatible
endif

" Plugin setup
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'scrooloose/nerdtree'
Plugin 'morhetz/gruvbox'

Plugin 'ervandew/supertab'

Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'

"Plugin 'wincent/command-t'

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

set background=dark    " Setting dark mode
colorscheme gruvbox

" Store lots of :cmdline history
set history=1000

set showcmd     " Show incomplete cmds down the bottom
set showmode    " Show current mode down the bottom

set incsearch   " Find the next match as we type the search
set hlsearch    " Highlight searches by default

" Turn on syntax highlighting
syntax on

" Show line numbers
set number

" Set 80-char line lenght
set colorcolumn=80
highlight ColorColumn ctermbg=darkgray

" Default indent settings
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent

" Some stuff to get the mouse going in term
set mouse=a
if !has("nvim")
    set ttymouse=xterm2
endif

set omnifunc=syntaxcomplete#Complete

" Map ; to :
nnoremap ; :

" Remember that ; and , where used to repeat character searches
" fix command that you shadowed with the prevoius one
nnoremap <Leader>; ;
" for symmetry add the following command
nnoremap <Leader>, ,

" More natural split opening
set splitbelow
set splitright

" HJKL split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" H - begin of the line, L - end
nnoremap H ^
nnoremap L g_

" Defines :te shortcut which expands to :tabedit
cnoreabbrev <expr> te getcmdtype() == ":" && getcmdline() == 'te' ? 'tabedit' : 'te'

map <C-n> :NERDTreeToggle<CR> " ctrl+n to open NERDTree
"autocmd vimenter * NERDTree " open NERDTree on startup
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"set statusline=%<%f\ %h%m%r%{kite#statusline()}%=%-14.(%l,%c%V%)\ %P
"set laststatus=2  " always display the status line

" If installed using Homebrew
"set rtp+=/usr/local/opt/fzf

nmap <Leader>F :Files<CR>
nmap <Leader>f :GFiles<CR>

nnoremap <C-p> :Files<Cr>
