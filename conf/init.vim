"nter --install  Vim plug
" https://github.com/junegunn/vim-plug
" ------------------------------------------------------------------------------

let g:plugin_path = '~/.config/nvim/plugged'

call plug#begin(g:plugin_path)

""" Themes
Plug 'arcticicestudio/nord-vim'
Plug 'tomasr/molokai'
""" Tmux theme generator
Plug 'edkolev/tmuxline.vim'

""" Basics
" File browser
Plug 'scrooloose/nerdtree'
" Manage buffers in a list
Plug 'jlanzarotta/bufexplorer'
" Syntax and highlighting for every language
Plug 'sheerun/vim-polyglot'
" Make it easy to add/remove/change brackets, quotes etc
Plug 'tpope/vim-surround'
" Status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Insert or delete brackets, parens, quotes in pair.
Plug 'jiangmiao/auto-pairs'
" Allow plugins to be repeated with dot
Plug 'tpope/vim-repeat'
" Fix whitespaces
Plug 'bronson/vim-trailing-whitespace'
" Close buffers without losing window layout
Plug 'moll/vim-bbye'
" Remember cursor position
Plug 'farmergreg/vim-lastplace'

""" IDE features
" Autocompletion
Plug 'Valloric/YouCompleteMe', {'do' : './install.py --go-completer'}
" Snippits
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Fuzzy find
Plug 'ctrlpvim/ctrlp.vim'
" Syntax checks
Plug 'vim-syntastic/syntastic'
" Commenting
Plug 'tpope/vim-commentary'
" Searching
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'eugen0329/vim-esearch'

""" Git
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive'

""" Languages
" Python
Plug 'python-mode/python-mode', { 'branch': 'develop' }
" Golang
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Lua
Plug 'xolox/vim-misc'
Plug 'xolox/vim-lua-ftplugin'
Plug 'xolox/vim-lua-inspect'
" Javascript
Plug 'pangloss/vim-javascript'
" Markdown
Plug 'JamshedVesuna/vim-markdown-preview'

call plug#end()

" Shortcut for checking if a plugin is loaded
function! s:has_plugin(plugin)
  let lookup = 'g:plugs["' . a:plugin . '"]'
  return exists(lookup)
endfunction

"  General config
" ------------------------------------------------------------------------------

" Theme
augroup nord-overrides
  autocmd!
  autocmd ColorScheme nord highlight VertSplit ctermbg=NONE ctermfg=8 guibg=NONE guifg=#434C5E
  autocmd ColorScheme nord highlight jsGlobalObjects ctermbg=NONE ctermfg=15 guibg=NONE guifg=#B48EAD
  autocmd ColorScheme nord highlight jsThis ctermbg=NONE ctermfg=11 guibg=NONE guifg=#BF616A
  autocmd ColorScheme nord highlight Comment ctermbg=NONE ctermfg=11 guibg=NONE guifg=#BF616A
augroup END

" Enable mouse
set mouse=a

set background=dark
silent! colorscheme nord

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags='li\|p'

" Set <space> to leader
let mapleader=','
let maplocalleader='\'

" Turn off swapfiles
set noswapfile
set nobackup
set nowb

" Allow editing of binary files
" Must be set before expandtab
" http://stackoverflow.com/a/26901774
set binary

" Enable term 24 bit colour
set termguicolors

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

" Use ``indent`` based folding
set foldmethod=indent
" Disable all folds on file open until `zc` or `zM` etc is used
set nofoldenable

" With :set hidden, opening a new file when the current buffer has unsaved
" changes causes files to be hidden instead of closed
set hidden

" Allow tab names to be remembered in sessions
set sessionoptions+=tabpages,globals

" Briefly move the cursor to the matching brace
set showmatch

" Lazyredraw attempts to solve Vim lag by reducing the amount of
" processing required. When enabled, any action that is not typed
" will not cause the screen to redraw
set lazyredraw

" Don't display the current mode (Insert, Visual, Replace)
" in the status line. This info is already shown in the
" Airline status bar.
set noshowmode

" Stop vim trying to syntax highlight long lines, typically found in minified
" files. This greatly reduces lag yet is still wide enough for large displays
set synmaxcol=500

" Highlight current line
set cursorline

" Indent using two spaces.
set softtabstop=4
set tabstop=4
set shiftwidth=4

" Smoother scrolling when moving horizontally
set sidescroll=1

" Use spaces, not tabs
set expandtab

" Don't scan included files. The .tags file is more performant.
set complete-=i
set complete+=kspell

" Prevent autocomplete options opening in scratchpad
set completeopt-=preview

" This is set low so that gitgutter updates reasonably quickly
" https://github.com/airblade/vim-gitgutter#when-are-the-signs-updated
set updatetime=300

" Don't wrap lines
set nowrap

" Keep the cursor in the same place when switching buffers
set nostartofline

" Show col and line position in the statusbar
set ruler

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Ignore case of searches
set ignorecase

" If a pattern contains an uppercase letter
" it is case sensitive, otherwise, it is not
set smartcase

" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamedplus

" Spell check
set spelllang=en

" Where it should get the dictionary files
let g:spellfile_URL = 'http://ftp.vim.org/vim/runtime/spell'

" For autocompletion, complete as much as you can.
set wildmode=list:longest,full

" don't add extra space after ., !, etc. when joining
set nojoinspaces

" Eliminate delay when switching modes
set ttimeoutlen=0

" Auto save changes before switching buffer
set autowrite

" Add the g flag to search/replace by default
set gdefault

" Centralize backups, swapfiles and undo history
set backupdir=~/.config/nvim/backups
set directory=.,$TEMP " Stop the swp file warning

if has("persistent_undo")
  set undodir=~/.config/nvim/undo
  set undofile
  set undolevels=1000
  set undoreload=10000
endif

" Don’t create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*

" Respect modeline in files
set modeline
set modelines=4

" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure

" Show “invisible” characters
set lcs=tab:▸\ ,trail:·,nbsp:_
set list

" Disable error bells
set noerrorbells

" Don't show the intro message when starting Vim
" Also suppress several 'Press Enter to continue messages' especially
" with FZF
set shortmess=aoOtIWcFs

" Show the current mode
set title

" Show the (partial) command as it’s being typed
set showcmd

" Line numbers
set number
set relativenumber

" Path and file extensions to look for when using `gf`
set suffixesadd+=.css,index.css,.js,.jsx,.scss
set path+=.,src

" Start scrolling before cursor gets to the edge
set scrolloff=5
set sidescrolloff=15
set sidescroll=1

" Remap annoying mistakes to something useful
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Qa q
cnoreabbrev Qall qall

" Key mappings
" ------------------------------------------------------------------------------

" gf but in a vsplit
nnoremap gv :vertical wincmd f<cr>

" Save file
nnoremap <silent><leader>w :silent w<cr>

" Switch to last buffer
nnoremap <leader><leader> <C-^>
" Show registers
nnoremap <leader>s :reg<cr>
" Close current buffer
nnoremap <silent><leader>x :bd<cr>

" Force j and k to work on display lines
nnoremap k gk
nnoremap j gj
vnoremap k gk
vnoremap j gj

" Map <C-i> to <f7> with Karabiner so tab can be used at the same time
nnoremap <f7> <C-i>

" Delete line but preserve the space
nnoremap dD S<Esc>

" Make `Y` work from the cursor to the end of line
nnoremap Y y$

" Reformat whole file and move back to original position
nnoremap g= gg=G``

" Use K to join current line with line above, just like J does with line below
nnoremap K kJ

" Automatically jump to end of pasted text
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" Split
noremap <silent><leader>h :split<cr>
noremap <silent><leader>v :vsplit<cr>

" Switch buffers
nnoremap <silent>H :silent bp<CR>
nnoremap <silent>L :silent bn<CR>

" Spellcheck
nnoremap <F6> :setlocal spell!<cr>

" Clear search (highlight)
nnoremap <silent> <leader>k :noh<cr>

" Automatically 'gv' (go to previously selected visual block)
" after indenting or unindenting.
vnoremap < <gv
vnoremap > >gv

" Press enter for newline without insert
nnoremap <cr> o<esc>
" but don't effect command line mode
autocmd CmdwinEnter * nnoremap <CR> <CR>
autocmd CmdwinLeave * nnoremap <cr> o<esc>

" Allow sourcing of vimrc
nnoremap <leader>y :source ~/.config/nvim/init.vim<cr>
" Allow editing of vimrc
nnoremap <leader>e :edit ~/.config/nvim/init.vim<cr>

if exists(':tnoremap')
  " Allow movement seamlessly with terminals
  tnoremap <C-h> <C-\><C-n><C-w>h
  tnoremap <C-j> <C-\><C-n><C-w>j
  tnoremap <C-k> <C-\><C-n><C-w>k
  tnoremap <C-l> <C-\><C-n><C-w>l
endif

let g:python_host_prog = "/usr/local/bin/python3"

"  Plugin config
" ------------------------------------------------------------------------------
if s:has_plugin('vim-esearch')
    let g:esearch = {
          \ 'adapter':    'ag',
          \ 'backend':    'vimproc',
          \ 'out':        'win',
          \ 'batch_size': 1000,
          \ 'use':        ['visual', 'hlsearch', 'last'],
          \}
endif

if s:has_plugin('vim-bbye')
    nnoremap <Leader>q :Bdelete<CR>
endif

if s:has_plugin('vim-markdown-preview')
    let g:vim_markdown_preview_github=1
    let g:vim_markdown_preview_hotkey='<C-m>'
    let g:vim_markdown_preview_browser = 'Google Chrome'
endif

if s:has_plugin('tmuxline.vim')
    let g:tmuxline_preset = 'full'
    let g:tmuxline_separators = {
    \ 'left' : '⮀',
    \ 'left_alt': '⮁',
    \ 'right' : '⮂',
    \ 'right_alt' : '⮃',
    \ 'space' : ' '}
endif

" Fix whitespaces before save
if s:has_plugin('vim-trailing-whitespace')
  autocmd BufWritePre <buffer> :FixWhitespace
endif

if s:has_plugin('YouCompleteMe')
    let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
    let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
endif

if s:has_plugin('ultisnips')
    let g:UltiSnipsExpandTrigger = '<C-j>'
    let g:UltiSnipsJumpForwardTrigger = '<C-j>'
    let g:UltiSnipsJumpBackwardTrigger = '<C-k>'
endif

if s:has_plugin('ctrlp.vim')
    set wildignore+=*/tmp/*,*.so,*.swp,*.zip
    set wildignore+=*.DS_Store,*.egg,*.egg-info/*,*.log,*.pyc,*.pyo,*.swp
    set wildignore+=*.cache/*,.eggs,.env,.flaskenv,.idea/*,.mypy_cache/*
    set wildignore+=.pytest_cache/*,.tox/*,.vagrant,_mailinglist,*build/*
    set wildignore+=*dist/*,_build/*,*.cover.log,*.coverage
    set wildignore+=.venv/*,*venv-*/*,*venv/*
    set wildignore+=*.coverage.*,*htmlcov/*
endif

if s:has_plugin('syntastic')
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*
  "let g:syntastic_python_checkers = ['flake8', 'mypy']
  let g:syntastic_python_checkers = ['flake8']
  let g:syntastic_go_checkers = ['golint', 'govet']

  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list = 1
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 0
endif

if s:has_plugin('bufexplorer')
  let g:bufExplorerDisableDefaultKeyMapping = 1
  let g:bufExplorerShowNoName = 1
  nnoremap <leader>B :BufExplorer<cr>
endif

if s:has_plugin('vim-polyglot')
  let g:polyglot_disabled = ['markdown', 'scss']
  let g:jsx_ext_required = 0
endif

if s:has_plugin('nerdtree')
  let g:NERDTreeWinSize = 30
  let NERDTreeIgnore = ['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
  let NERDTreeShowHidden = 1
  let NERDTreeHijackNetrw = 1
  let NERDTreeAutoDeleteBuffer = 1

  let NERDTreeShowBookmarks=1
  let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
  let NERDTreeChDirMode=0
  let NERDTreeQuitOnOpen=1
  let NERDTreeMouseMode=2
  let NERDTreeShowHidden=1
  let NERDTreeKeepTreeInNewTab=1
  let g:nerdtree_tabs_open_on_gui_startup=0
  noremap <C-n> :NERDTreeToggle<CR>
endif

if executable('jq')
  " JSON beautifier
  nnoremap <leader>z :%!jq '.'<cr>
endif

if s:has_plugin('vim-airline')
  let g:airline_theme = 'nord'
  let g:airline#extensions#branch#enabled = 1
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#tmuxline#enabled = 0
  let g:airline#extensions#tabline#enabled = 1 " Enable the list of buffers
  let g:airline#extensions#tabline#buffers_label = ''
  let g:airline#extensions#tabline#fnamemod = ':t' " Show the filename
  let g:airline#extensions#tabline#fnamecollapse = 0
  let g:airline#extensions#tabline#show_tab_nr = 0
  let g:airline#extensions#tabline#buffer_nr_show = 0
  let g:airline#extensions#tabline#show_close_button = 0
  let g:airline#extensions#default#layout = [
        \ [ 'a', 'b', 'c' ],
        \ [ 'x', 'z', 'error', 'warning' ]
        \ ]
  let g:airline_powerline_fonts = 0
  let g:airline_theme = 'bubblegum'
  let g:airline#extensions#whitespace#enabled = 0

" to use fancy symbols for airline, uncomment the following lines and use a
" patched font (more info on the README.rst)
endif

if s:has_plugin('vim-gitgutter')
  nmap [c <Plug>GitGutterPrevHunk
  nmap ]c <Plug>GitGutterNextHunk
endif

if s:has_plugin('python-mode')
  " let g:pymode_doc = 1
  " let g:pymode_doc_bind = 'K'
  let g:pymode_motion = 1
  let g:pymode_virtualenv = 1
  let g:pymode_syntax = 1
  let g:pymode_syntax_all = 1
  let g:pymode_rope = 1
  let g:pymode_python = 'python3'
  let g:pymode_lint_checkers = ['flake8']
endif

if s:has_plugin('vim-go')
    " run :GoBuild or :GoTestCompile based on the go file
    set rtp+=$GOPATH/src/golang.org/x/lint/misc/vim

    function! s:build_go_files()
      let l:file = expand('%')
      if l:file =~# '^\f\+_test\.go$'
        call go#test#Test(0, 1)
      elseif l:file =~# '^\f\+\.go$'
        call go#cmd#Build(0)
      endif
    endfunction

    let g:go_list_type = "quickfix"
    let g:go_fmt_command = "goimports"
    let g:go_fmt_fail_silently = 1

    let g:go_highlight_types = 1
    let g:go_highlight_fields = 1
    let g:go_highlight_functions = 1
    let g:go_highlight_methods = 1
    let g:go_highlight_operators = 1
    let g:go_highlight_build_constraints = 1
    let g:go_highlight_structs = 1
    let g:go_highlight_generate_tags = 1
    let g:go_highlight_space_tab_error = 0
    let g:go_highlight_array_whitespace_error = 0
    let g:go_highlight_trailing_whitespace_error = 0
    let g:go_highlight_extra_types = 1

    autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4

    augroup completion_preview_close
      autocmd!
      if v:version > 703 || v:version == 703 && has('patch598')
        autocmd CompleteDone * if !&previewwindow && &completeopt =~ 'preview' | silent! pclose | endif
      endif
    augroup END

    augroup go

      au!
      au Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
      au Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
      au Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
      au Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

      au FileType go nmap <Leader>dd <Plug>(go-def-vertical)
      au FileType go nmap <Leader>dv <Plug>(go-doc-vertical)
      au FileType go nmap <Leader>db <Plug>(go-doc-browser)

      au FileType go nmap <leader>r  <Plug>(go-run)
      au FileType go nmap <leader>t  <Plug>(go-test)
      au FileType go nmap <Leader>gt <Plug>(go-coverage-toggle)
      au FileType go nmap <Leader>i <Plug>(go-info)
      au FileType go nmap <silent> <Leader>l <Plug>(go-metalinter)
      au FileType go nmap <C-g> :GoDecls<cr>
      au FileType go nmap <leader>dr :GoDeclsDir<cr>
      au FileType go imap <C-g> <esc>:<C-u>GoDecls<cr>
      au FileType go imap <leader>dr <esc>:<C-u>GoDeclsDir<cr>
      au FileType go nmap <leader>rb :<C-u>call <SID>build_go_files()<CR>

    augroup END
endif

" Output the current syntax group
nnoremap <f10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<cr>

" Automatic commands
" ------------------------------------------------------------------------------

augroup always-open-signcolumn
  autocmd!
  autocmd BufEnter * sign define dummy
  autocmd BufEnter * execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')
augroup END

" Open help in a vertical split
augroup vimrc-help
  autocmd!
  autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | setlocal relativenumber | endif
augroup END

augroup file-types
  autocmd!

  " Override some syntaxes so things look better
  autocmd BufNewFile,BufRead *.html setlocal syntax=swig
  autocmd BufNewFile,BufRead *.sss setlocal syntax=stylus
  autocmd BufNewFile,BufRead *.ts,*.snap*,*.es6,*.tsx setlocal filetype=javascript.jsx
  autocmd BufNewFile,BufRead *stylelintrc,*eslintrc,*babelrc,*jshintrc setlocal syntax=json
  autocmd BufNewFile,BufRead *.css setlocal syntax=scss
  autocmd BufNewFile,BufRead *.cshtml setlocal filetype=cshtml

  " Wrap text and turn on spell for markdown files
  autocmd BufNewFile,BufRead *.md setlocal wrap linebreak spell filetype=markdown

  " Automatically wrap at 72 characters and spell check git commit messages
  autocmd FileType gitcommit setlocal textwidth=72
  autocmd FileType gitcommit setlocal spell

  " Allow stylesheets to autocomplete hyphenated words
  autocmd FileType css,scss,sass setlocal iskeyword+=-
augroup END

" Switch between normal and relative line numbers and cursorline
" when switching modes
augroup highlight-when-switching-modes
  autocmd!
  autocmd InsertEnter * setlocal number norelativenumber nocursorline
  autocmd InsertLeave * setlocal relativenumber cursorline
  autocmd WinEnter    * setlocal cursorline
  autocmd WinLeave    * setlocal nocursorline
augroup END

" Periodically check for file changes
augroup checktime
  autocmd!
  autocmd CursorHold * silent! checktime
augroup END

" Resize splits when vim changes size (like with tmux opening/closing)
augroup auto-resize
  autocmd!
  autocmd VimResized * wincmd =
augroup END

" Autocomplete
augroup omnifuncs
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup endif
