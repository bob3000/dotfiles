" Create once and then comment
" silent !mkdir -p $HOME/.vim/backups > /dev/null 2>&1
" silent !mkdir -p $HOME/.vim/undo > /dev/null 2>&1

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin()
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'preservim/tagbar'
Plug 'sainnhe/everforest'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
call plug#end()

try
  colorscheme everforest
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme habamax
endtry

syntax on
filetype plugin indent on

set autoindent
set autowriteall
set background=dark
set backspace=indent,eol,start
set backupdir=$HOME/.vim/backups
set clipboard=unnamed
set cursorline
set directory=.,$TEMP " Stop the swp file warning
set encoding=utf-8
set expandtab
set exrc
set foldmethod=indent
set guicursor = "a:blinkon100,n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"
set hidden
set history=700
set hlsearch
set ignorecase
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.
set modeline
set mouse=a
set nobackup
set nocompatible
set noerrorbells
set nofoldenable
set nojoinspaces
set nolinebreak
set nostartofline
set noswapfile
set nowb
set nowrap
set number
set omnifunc=syntaxcomplete#Complete
set relativenumber
set ruler
set secure
set shiftround
set shiftwidth=2
set showcmd
set showmatch
set showmode
set sidescroll=1
set sidescrolloff=15
set signcolumn=auto
set smartcase
set smartindent
set spell
set spelllang=en
set splitbelow
set splitright
set synmaxcol=500
set tabstop=2
set t_Co=256
set termguicolors
set textwidth=0
set title
set ttyfast
set undodir=$HOME/.vim/undo
set undofile
set undolevels=1000
set undoreload=10000
set updatetime=500
set wildignore+=*.swp,*.bak,*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*,node_modules/*
set wildmenu
set wildmode=list:longest,list:full
set wrapscan

let mapleader = " "
let g:spellfile_URL = 'http://ftp.vim.org/vim/runtime/spell'
let g:everforest_transparent_background = 2
hi Normal guibg=NONE ctermbg=NONE
let g:lightline = {
      \ 'colorscheme': 'apprentice',
      \ }

" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" uniform yank behaviour
map Y y$
" no search highlight
map <leader><Esc> :nohlsearch<CR>

" Move up/down editor lines
nnoremap j gj
nnoremap k gk

" buffer and windows
map <C-s> :w<cr>
map <C-c> :bd<cr>
map <C-q> :q<cr>
map <C-_> :split<cr>
map <C-/> :vsplit<cr>

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim

" FZF
nmap <leader>sb :Buffers<cr>
nmap <leader>sg :Rg<cr>
nmap <leader>ff :Files<cr>
nmap <leader>fg :GFiles<cr>
nmap <leader>cs :TagbarToggle<CR>
nmap <leader>ct :!ctags -R .<CR>

" terminal
nmap <leader>gg :terminal lazygit<CR>
nmap <leader>gt :terminal<CR>

" execute command
nmap <leader><Enter> !!bash<CR>

" Switch between normal and relative line numbers and cursorline
" when switching modes
augroup highlight-when-switching-modes
  autocmd!
  autocmd InsertEnter * setlocal number norelativenumber nocursorline
  autocmd InsertLeave * setlocal relativenumber cursorline
  autocmd WinEnter    * setlocal cursorline
  autocmd WinLeave    * setlocal nocursorline
augroup END
