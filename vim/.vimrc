" Vi improved, gotta be first
set nocompatible
" enable filetype extension
filetype on
filetype plugin on
filetype indent on " auto file type based indentation
syntax enable
" Settings
set noerrorbells                " No beeps
set number                      " Show line numbers
" indent allow backspacing over autoident
" eol allow backspacing over line breaks (join lines)
" start allow backspacing over the start of insert; CTRL-W and CTRL-U stop once
"   at the start of insert
set backspace=indent,eol,start  " Makes backspace key more powerful.
set showcmd                     " Show me what I'm typing
set showmode                    " Show current mode.
set noswapfile                  " Don't use swapfile
set nobackup                    " Don't create annoying backup files
set nowritebackup               " Don't waste disk io writing backup files
set splitright                  " Split vertical windows right to the current windows
set splitbelow                  " Split horizontal windows below to the current windows
set encoding=utf-8              " Set default encoding to UTF-8
if has('unix')
  set t_Co=256                    " use 256 colors in vim
endif
set autowrite                   " Automatically save before :next, :make etc.
set autoread                    " Automatically reread changed files without asking me anything
set laststatus=2
set hidden
set ruler                       " Show the cursor position all the time
au FocusLost * :wa              " Set vim to save the file on focus out.
set fileformats=unix,dos,mac    " Prefer Unix over Windows over OS 9 formats
set showmatch                   " Show matching brackets by flickering
set noshowmode                  " We show the mode with airline or lightline
set incsearch                   " Shows the match while typing
set hlsearch                    " Highlight found searches
set ignorecase                  " Search case insensitive...
set smartcase                   " ... but not when search pattern contains upper case characters
set clipboard=unnamedplus       " use 'global register for copy'

 "speed up vim
" set ttyfast   " indicates a fast terminal connection. More chars sent to screen
              " for redrawing
" set ttyscroll=3    " Maximum no. of lines to scroll the screen. If more screen is
                   " is redrawn. In a terminal where scrolling is slow but
                   " redraw is fast a small number like 3 speeds up displaying
set lazyredraw   " does not redraw the screen on nontyped commands
set updatetime=250  " git gutter faster updates 

set cursorline
                     

" speed up syntax highlighting on slow computer
" set nocursorcolumn  " Don't highlight the screen column of the cursor
" set nocursorline " Don't highlight the screen line of the cursor

" syntax sync minlines=256
" set synmaxcol=300
" set re=1

" open help vertically
" command! -nargs=* -complete=help Help vertical belowright help <args>
" autocmd FileType help wincmd L

" automatic automcomplete for html files
" autocmd FileType html set omnifunc=htmlcomplete#CompleteTags

" Make Vim to handle long lines nicely.
set wrap   " wrap wrong lines that extend beyond visible screen
set textwidth=79 " was 79
set formatoptions=qn1 " :h fo-table for details add r for auto insert comment leader
set colorcolumn=80 " was 80
"set relativenumber
"set norelativenumber

" mail line wrapping
au BufRead /tmp/mutt-* set tw=72

set autoindent " copy indent from current when starting a new line. Typing <CR>
               " in insert mode or 'o' 'O' in normal triggers it

" set complete-=i
set smarttab " insert blanks according to shiftwidth, tabstop, softtab, BS will
             " delete shiftwidth

" default tab settings based on google style guide
"set tabstop=8   " 8 spaces for a tab
set shiftwidth=8    " 8 spaces for identation
set expandtab   " insert space characters whenever tab is pressed
set softtabstop=8 " number of spaces that a <Tab> counts for while performing
                  " editing operations like inserting a <Tab> or using <BS>

" Shortcut to rapidly toggle `set list`
" nmap <leader>m :set list!<CR>
" set listchars=tab:▸\ ,eol:¬,trail:· " show tabs, eols and trailing spaces


" Unrecogised extensions fix
au BufRead,BufNewFile *.rockspec set filetype=lua
au BufRead,BufNewFile *.md       set filetype=markdown
au Bufread,BufNewFile *.org.txt  set filetype=org

" Ask to clean all trailing white-spaces upon saving
" autocmd BufWritePre * :%s/\s\+$//ec

" Use specific spacing for different formats
" expandtab, et:    <Tab> -> spaces
" tabstop, ts:      length of a <Tab>
" shiftwidth, sw:   spaces for autoindent
" softtabstop, sts: how many spaces a <Tab> inserts or <BS> removes
au FileType verilog,matlab setl et ts=4 sw=4 sts=4
au FileType lua setl et ts=3 sw=3 sts=2
au FileType c,cuda,tex,bib setl et ts=4 sw=2 sts=2
au FileType make set noexpandtab shiftwidth=8 softtabstop=0

" >>> ended here refactoring
set nrformats-=octal
set shiftround

" Time out on key codes but not mappings.
" Basically this makes terminal Vim work sanely.
set notimeout
set ttimeout
set ttimeoutlen=10

" Better Completion
set complete=.,w,b,u,t,i
set completeopt=longest,menuone

let mapleader=" "  " set map leader key to comma

" configure wildmenu tab completion
set wildmode=list:longest,full
set wildignorecase

" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

" folding support
set foldenable                  " enable folding
set foldlevelstart=10           " open most folds by default
set foldnestmax=10              " 10 nested fold max
" space open/closes folds
nnoremap <space> za
set foldmethod=indent           " fold based on indent level

" move vertically by visual line not ignoring wrapped lines
nnoremap j gj
nnoremap k gk

" save session
nnoremap <leader>s :mksession<CR>

" open ag.vim
nnoremap <leader>a :Ack



" number of commands that are remembered
if &history < 1000
  set history=50
endif

" set maximum number of tabs
if &tabpagemax < 50
  set tabpagemax=50
endif

" create viminfo on exit to resume where you left off
if !empty(&viminfo)
  set viminfo^=!
endif

" number of lines visible above the cursor
if !&scrolloff
  set scrolloff=1
endif

" minimum number of screen columns to keep to the right and left of the cursor
if !&sidescrolloff
  set sidescrolloff=5
endif

" last line that doesn't fit on window will be displayed as much as possible
set display+=lastline

" gvim specific settings
set guioptions-=m "menu bar
set guioptions-=T "toolbar
set guioptions-=r "scrollbar

" Center the screen
nnoremap <space> zz

" C-d to delete in insert mode
inoremap <C-d> <Del>

" persistent undo survives vim exits
if has("persistent_undo")
  set undodir=~/.vim/undodir/
  silent call system('mkdir -p ' . &undodir)
  set undofile
endif

" use mouse if available
if has('mouse')
  set mouse=a
endif

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" autocmd BufReadPost *
"  \ if line("'\"") >= 1 && line("'\"") <= line("$") |
"  \   exe "normal! g`\"" |
"  \ endif
augroup resCur
  autocmd!
  autocmd BufReadPost * call setpos(".", getpos("'\""))
augroup END

autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0

" Allow saving of files as sudo when i forgot to start vim using sudo
cmap w!! w !sudo tee > /dev/null %

" keeps the visual selection active after indenting
vmap > >gv
vmap < <gv

if has('gui_running')
  set guifont=Inconsolata-g\ for\ Powerline\ 11
endif


" source vim plug and plugins
source ~/.vimrc.plug

" source plugins settings
source ~/.vimrc.plugins.settings
