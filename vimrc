set nocompatible " be iMproved, required
filetype off " required

" Specify a directory for vim-plug
" nvim:
"call plug#begin('~/.config/nvim/plugged')
" vim:
call plug#begin()

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'mileszs/ack.vim'

Plug 'jiangmiao/auto-pairs'

Plug 'morhetz/gruvbox'

Plug 'HerringtonDarkholme/yats.vim'

Plug 'wakatime/vim-wakatime'

" Initialize plugin system
call plug#end()

set background=dark " Setting dark mode
colorscheme gruvbox

" store lots of :cmdline history
set history=1000

set showcmd     " show incomplete cmds down the bottom
set showmode    " show current mode down the bottom

set incsearch   "find the next match as we type the search
set hlsearch    "hilight searches by default

" turn on syntax highlighting
syntax on

" show line numbers
set number relativenumber

" set 80-char line lenght
"set colorcolumn=80
let &colorcolumn="80,".join(range(120,999),",")
highlight ColorColumn ctermbg=darkgray

" default indent settings
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent

" always try to show 5 lines above and below the cursor
set scrolloff=5

"some stuff to get the mouse going in term
set mouse=a
if !has("nvim")
    set ttymouse=xterm2
endif

set omnifunc=syntaxcomplete#Complete

"more natural split opening
set splitbelow
set splitright

"HJKL split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"H - begin of the line, L - end
nnoremap H ^
nnoremap L g_

"defines :te shortcut which expands to :tabedit
cnoreabbrev <expr> te getcmdtype() == ":" && getcmdline() == 'te' ? 'tabedit' : 'te'

map <C-n> :NERDTreeToggle<CR> " ctrl+n to open NERDTree
"autocmd vimenter * NERDTree " open NERDTree on startup
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Ctrl-p to open fzf's Files
nnoremap <C-p> :Files<Cr>

" Ctrl-g to open Rg
nnoremap <C-g> :Rg<Cr>

" map jj to Esc
" imap jj <Esc>

if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

" map space to leader
let mapleader = " "

nmap <leader>nt :NERDTreeToggle<CR>

" rg current word
nnoremap <silent> <Leader>rg :Rg <C-R><C-W><CR>

" switch buffers without saving every time
set hidden

"operations on buffers
nmap <leader>lb :Buffers<CR>
nmap <leader>bn :bnext<CR>
nmap <leader>bp :bprevious<CR>
nmap <leader>bf :bfirst<CR>
nmap <leader>bl :blast<CR>

" tab/shift+tab to scroll through the buffers
nnoremap  <silent>   <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
nnoremap  <silent> <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>

highlight Normal ctermbg=none
highlight NonText ctermbg=none

function! ScrollQuarter(move)
    let height=winheight(0)

    if a:move == 'up'
        let key="\<C-Y>"
    else
        let key="\<C-E>"
    endif

    execute 'normal! ' . height/4 . key
endfunction

" binds up/down keys to scroll quater of the screen
nnoremap <silent> <up> :call ScrollQuarter('up')<CR>
nnoremap <silent> <down> :call ScrollQuarter('down')<CR>

