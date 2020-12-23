"  Vim plug
" https://github.com/junegunn/vim-plug
" ------------------------------------------------------------------------------

let g:plugin_path = '~/.config/nvim/plugged'

call plug#begin(g:plugin_path)

""" Themes
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
" Close buffers without losing window layout
Plug 'moll/vim-bbye'
" Remember cursor position
Plug 'farmergreg/vim-lastplace'
" editor config
Plug 'editorconfig/editorconfig-vim'

""" IDE features
" Autocompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Formatting
Plug 'Chiel92/vim-autoformat'
" Fuzzy find
Plug 'ctrlpvim/ctrlp.vim'
" Syntax checks
Plug 'vim-syntastic/syntastic'
" Commenting
Plug 'tpope/vim-commentary'

""" Git
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive'

""" Languages
" rust (used by syntastic)
Plug 'rust-lang/rust.vim'
" javascript (used by syntastic)
Plug 'quramy/tsuquyomi'
" jsonc
Plug 'kevinoid/vim-jsonc'
" toml
Plug 'cespare/vim-toml'
" yaml
Plug 'stephpy/vim-yaml'
" tables
Plug 'godlygeek/tabular'
"" Markdown
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'mzlogin/vim-markdown-toc'
Plug 'plasticboy/vim-markdown'"

call plug#end()

" Shortcut for checking if a plugin is loaded
function! s:has_plugin(plugin)
  let lookup = 'g:plugs["' . a:plugin . '"]'
  return exists(lookup)
endfunction

"  General config
" ------------------------------------------------------------------------------

" Enable mouse
set mouse=a

set background=dark
silent! colorscheme molokai
" do not display the tilde on the left
hi! EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg
" transparent background
hi Normal guibg=NONE ctermbg=NONE

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
set colorcolumn=+1,+41

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
set softtabstop=2
set tabstop=2
set shiftwidth=2

" Use spaces, not tabs
set expandtab

" Smoother scrolling when moving horizontally
set sidescroll=1

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
set suffixesadd+=.css,index.css,.js,.jsx,.scss,.ts,.tsx
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

" move to beginning of the line in ex mode
:cnoremap <C-a> <C-b>

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

" Save buffer on focus loss
autocmd FocusLost * silent! wa

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

if executable('jq')
  " JSON beautifier
  nnoremap <leader>z :%!jq '.'<cr>
endif

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
  autocmd BufNewFile,BufRead *.tsx setlocal filetype=typescriptreact
  autocmd BufNewFile,BufRead *stylelintrc,*eslintrc,*babelrc,*jshintrc setlocal syntax=json
  autocmd BufNewFile,BufRead *.css setlocal syntax=scss

  " Wrap text and turn on spell for markdown files
  autocmd BufNewFile,BufRead *.md setlocal wrap linebreak spell filetype=markdown

  " Automatically wrap at 72 characters and spell check git commit messages
  autocmd FileType gitcommit setlocal textwidth=72
  autocmd FileType gitcommit setlocal spell

  " Allow stylesheets to autocomplete hyphenated words
  autocmd FileType css,scss,sass setlocal iskeyword+=-

  " Indention for certain filetypes
  autocmd FileType c setlocal tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab
  autocmd FileType vim setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  autocmd FileType python setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
  autocmd FileType javascript,javascrip.jsx,json,jsonc,typescript,typescriptreact,tsx setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  autocmd FileType html,css setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
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

"  Plugin config
" ------------------------------------------------------------------------------

" enable as soon as neovim 0.5 is released
" lua require'nvim_lsp'.rust_analyzer.setup({})
if s:has_plugin('rust.vim' )
  let g:rustfmt_autosave = 1
endif

if s:has_plugin('vim-bbye')
  nnoremap <Leader>q :Bdelete<CR>
endif

if s:has_plugin('vim-markdown-preview')
  let g:vim_markdown_preview_github=1
  let g:vim_markdown_preview_hotkey='<C-m>'
  let g:vim_markdown_preview_browser = 'firefox'
endif

if s:has_plugin('tmuxline.vim')
  let g:tmuxline_preset = 'full'
  let g:tmuxline_powerline_separators = 1
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
  " these are checked via COC plugin
  let g:syntastic_enable_c_checker = 0
  let g:syntastic_enable_rust_checker = 0
  let g:syntastic_enable_python_checker = 1
  let g:syntastic_enable_ruby_checker = 1

  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*

  "let g:syntastic_python_checkers = ['flake8', 'mypy']
  let g:syntastic_python_checkers = ['flake8']
  let g:syntastic_c_checkers = ['clang_tidy']
  let g:syntastic_ruby_checkers = ['rubocop']
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

if s:has_plugin('nerdtree')
  let g:NERDTreeWinSize = 30
  let NERDTreeIgnore = ['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$', '\.vscode']
  let NERDTreeHijackNetrw = 1
  let NERDTreeAutoDeleteBuffer = 1
  let NERDTreeShowBookmarks = 1
  let NERDTreeChDirMode = 0
  let NERDTreeQuitOnOpen = 1
  let NERDTreeMouseMode = 2
  let NERDTreeShowHidden = 1
  let NERDTreeKeepTreeInNewTab = 1
  let g:nerdtree_tabs_open_on_gui_startup = 0
  noremap <C-n> :NERDTreeToggle<CR>
endif

if s:has_plugin('vim-airline')
  let g:airline#extensions#branch#enabled = 1
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#tmuxline#enabled = 1
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
  let g:airline_theme = 'bubblegum'
  let g:airline#extensions#whitespace#enabled = 0
endif

if s:has_plugin('vim-autoformat')
  function! ToggleAutoformat()
    let g:autoformat_autoindent = (1 - g:autoformat_autoindent)
    let g:autoformat_retab = (1 - g:autoformat_retab)
    let g:autoformat_remove_trailing_spaces = (1 - g:autoformat_remove_trailing_spaces)
  endfunction

  augroup autoformat
    autocmd!
    " autocmd BufWrite * :Autoformat
    nnoremap <Leader>f :Autoformat<CR>
  augroup END

  let g:python3_host_prog = "/usr/bin/python"
  nnoremap <F3> :call ToggleAutoformat()<CR>
  nnoremap <Leader>f :Autoformat<CR>
endif

if s:has_plugin('coc.nvim')
  " Use <c-space> to trigger completion.
  if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
  else
    inoremap <silent><expr> <c-@> coc#refresh()
  endif

  " Use `[g` and `]g` to navigate diagnostics
  " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)

  " GoTo code navigation.
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Use K to show documentation in preview window.
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  " Applying codeAction to the selected region.
  " Example: `<leader>aap` for current paragraph
  xmap <leader>a  <Plug>(coc-codeaction-selected)
  nmap <leader>a  <Plug>(coc-codeaction-selected)

  " Remap keys for applying codeAction to the current buffer.
  nmap <leader>ac  <Plug>(coc-codeaction)
  " Apply AutoFix to problem on the current line.
  nmap <leader>qf  <Plug>(coc-fix-current)

  " Mappings for CoCList
  " Show all diagnostics.
  nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
  " Manage extensions.
  nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
  " Show commands.
  nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
  " Find symbol of current document.
  nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
  " Search workspace symbols.
  nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
  " Do default action for next item.
  nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
  " Do default action for previous item.
  nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
  " Resume latest coc list.
  nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
      call CocActionAsync('doHover')
    else
      execute '!' . &keywordprg . " " . expand('<cword>')
    endif
  endfunction

  augroup coc
    autocmd!
    " Highlight the symbol and its references when holding the cursor.
    autocmd CursorHold * silent call CocActionAsync('highlight')

    " Use Coc to format certain files
    autocmd FileType javascript,javascrip.jsx,json,jsonc,typescript,typescriptreact,tsx nmap <buffer><silent><Leader>f :call CocAction('format')<CR>
    autocmd FileType c nnoremap <buffer><silent><Leader>f :call CocAction('format')<CR>
    autocmd FileType rust nnoremap <buffer><silent><Leader>f :call CocAction('format')<CR>
    autocmd FileType python nnoremap <buffer><silent><Leader>f :call CocAction('format')<CR>
    autocmd FileType html nnoremap <buffer><silent><Leader>f :call CocAction('format')<CR>
    autocmd FileType yaml nnoremap <buffer><silent><Leader>f :call CocAction('format')<CR>
  augroup END
endif

