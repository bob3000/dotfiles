source ~/.vim/.vimrc.bundles
source ~/.vim/.vimrc.functions
source ~/.vim/.vimrc.keys

set nocompatible
set background=dark                             " Assume a dark background
filetype plugin indent on                       " Automatically detect file types.
syntax on                                       " Syntax highlighting
set mouse=a                                     " Automatically enable mouse usage
set mousehide                                   " Hide the mouse cursor while typing
scriptencoding utf-8

set autowrite                                   " Automatically write a file when leaving a modified buffer
set shortmess+=filmnrxoOtT                      " Abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
set virtualedit=onemore                         " Allow for cursor beyond last character
set history=1000                                " Store a ton of history (default is 20)
set spell                                       " Spell checking on
set hidden                                      " Allow buffer switching without saving

set showmode                                    " Display the current mode
set cursorline                                  " Highlight current line
set backspace=indent,eol,start                  " Backspace for dummies
set linespace=0                                 " No extra spaces between rows
set nu                                          " Line numbers on
set showmatch                                   " Show matching brackets/parenthesis
set incsearch                                   " Find as you type search
set hlsearch                                    " Highlight search terms
set winminheight=0                              " Windows can be 0 line high
set ignorecase                                  " Case insensitive search
set smartcase                                   " Case sensitive when uc present
set wildmenu                                    " Show list instead of just completing
set wildmode=list:longest,full                  " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]                   " Backspace and cursor keys wrap too
set scrolljump=5                                " Lines to scroll when cursor leaves screen
set scrolloff=3                                 " Minimum lines to keep above and below cursor
set foldenable                                  " Auto fold code
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.  " Highlight problematic whitespace

set nowrap                                      " Wrap long lines
set autoindent                                  " Indent at the same level of the previous line
set shiftwidth=4                                " Use indents of 4 spaces
set expandtab                                   " Tabs are spaces, not tabs
set tabstop=4                                   " An indentation every four columns
set softtabstop=4                               " Let backspace delete indent
set matchpairs+=<:>                             " Match, to be used with %
set pastetoggle=<F11>                           " pastetoggle (sane indentation on pastes)
set comments=sl:/*,mb:*,elx:*/                  " auto format comment blocks
set tags=./tags;/,~/.vimtags                    " ctags location

highlight clear SignColumn                      " SignColumn should match background
highlight clear LineNr                          " Current line number row will have same background color in relative mode.
highlight clear SpellBad                        " underline mispelled words
highlight SpellBad cterm=underline
set colorcolumn=80                              " Reminder to stay with 79 chars per line
highlight ColorColumn ctermbg=10
highlight Normal ctermfg=244 ctermbg=none

" Instead of reverting the cursor to the last position in the buffer, we
" set it to the first line when editing a git commit message
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
" Remove trailing whitespaces and ^M chars
autocmd FileType c,cpp,java,go,php,javascript,python,twig,xml,yml autocmd BufWritePre <buffer> call StripTrailingWhitespace()
autocmd FileType go autocmd BufWritePre <buffer> Fmt
autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
autocmd BufNewFile,BufRead *.coffee set filetype=coffee
autocmd FileType make setlocal noexpandtab

if has("autocmd") && exists("+omnifunc")
    autocmd Filetype *
        \if &omnifunc == "" |
        \setlocal omnifunc=syntaxcomplete#Complete |
        \endif
endif

if has ('x') && has ('gui')     " On Linux use + register for copy-paste
    set clipboard=unnamedplus
elseif has ('gui')              " On mac and Windows, use * register for copy-paste
    set clipboard=unnamed
endif

set backup                      " Backups are nice ...
if has('persistent_undo')
    set undofile                " So is persistent undo ...
    set undolevels=1000         " Maximum number of changes that can be undone
    set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
endif

if has('statusline')
    set laststatus=2
    " Broken down into easily includeable segments
    set statusline=%<%f\                     " Filename
    set statusline+=%w%h%m%r                 " Options
    "set statusline+=%{fugitive#statusline()} " Git Hotness
    set statusline+=\ [%{&ff}/%Y]            " Filetype
    set statusline+=\ [%{getcwd()}]          " Current dir
    set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif

if has('cmdline_info')
    set ruler                   " Show the ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
    set showcmd                 " Show partial commands in status line and
                                " Selected characters/lines in visual mode
endif

