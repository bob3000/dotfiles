syntax on
filetype plugin indent on
set autoindent
set autowriteall
set background=dark
set backspace=indent,eol,start
set clipboard=unnamedplus
set cursorline
set encoding=utf-8
set expandtab
set hidden
set history=700
set hlsearch
set ignorecase
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.
set modeline
set mouse=a
set nocompatible
set nojoinspaces
set nolinebreak
set nowrap
set number
set relativenumber
set ruler
set shiftround
set shiftwidth=2
set showcmd
set showmode
set signcolumn=auto
set smartcase
set smartindent
set spell
set synmaxcol=2048
set tabstop=2
set t_Co=256
set termguicolors
set textwidth=0
set ttyfast
set updatetime=500
set visualbell
set wildmenu
set wildmode=list:longest,list:full
set wildignore+=*.swp,*.bak,*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*
set wrapscan

let mapleader = " "

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

function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
  nmap <buffer> gd <plug>(lsp-definition)
  nmap <buffer> gs <plug>(lsp-document-symbol-search)
  nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
  nmap <buffer> gr <plug>(lsp-references)
  nmap <buffer> gi <plug>(lsp-implementation)
  nmap <buffer> gt <plug>(lsp-type-definition)
  nmap <buffer> <leader>rn <plug>(lsp-rename)
  nmap <buffer> [g <plug>(lsp-previous-diagnostic)
  nmap <buffer> ]g <plug>(lsp-next-diagnostic)
  nmap <buffer> K <plug>(lsp-hover)
  nmap <buffer> <leader>cf <plug>(lsp-document-format)

  let g:lsp_format_sync_timeout = 1000
  autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')

  " refer to doc to add more commands
endfunction

augroup lsp_install
  au!
  " call s:on_lsp_buffer_enabled only for languages that has the server registered.
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin()
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/vim-lsp'
Plug 'preservim/tagbar'
Plug 'sainnhe/everforest'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
call plug#end()

colorscheme everforest
