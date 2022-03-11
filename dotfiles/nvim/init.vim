syntax enable                               " enables syntax highlight

" ###### sets ######

set autoindent                              " enables auto-indenting
set number relativenumber                   " enables number bar with line numbers relative to current line
set showcmd                                 " enables partial commands in bottom line
set cursorline                              " highlights current line
highlight Cursorline cterm=NONE ctermbg=darkblue ctermfg=white
                                            " changes how cursorline is styled

set tabstop=2 shiftwidth=2 expandtab        " converts tabs -> spaces, defaults to 2 space tabs, and sets 2 space default for reindents
set list                                    " shows spaces, tabs, etc.
set listchars=eol:↪,tab:--                  " sets the eol and tab characters

set lazyredraw                              " doesn't redraw when executing macros, etc.
set ttyfast                                 " sends commands faster

set wildmenu                                " sets a horizontal strip to navigate through menus (and can use left/right to navigate)
set showmatch                               " highlights open and close containers

set incsearch                               " jumps to next logical match as you type with search (/)
set hlsearch                                " highlights all found items once search command is finished

set backspace=indent,eol,start              " allows you to <BS> through indentation, across eols, and past the start of your insert

" ###### remaps ######

let mapleader=","                           " sets the vim leader key to ,
nnoremap <leader><space> :nohlsearch<CR>    " turns off search highlighting with <leader><space> in normal mode, no recursion

noremap <C-v> <C-w>v                        " maps opening a (vertical) new pane in normal mode to Ctrl-v 
noremap <C-s> <C-w>s                        " maps opening a (horizontal) new pane in normal mode to Ctrl-s 
noremap <C-j> <C-w>j                        " maps navigating down a pane in normal mode to Ctrl-j
noremap <C-k> <C-w>k                        " maps navigating up a pane in normal mode to Ctrl-k
noremap <C-h> <C-w>h                        " maps navigating left a pane in normal mode to Ctrl-h
noremap <C-l> <C-w>l                        " maps navigating right a pane in normal mode to Ctrl-l
