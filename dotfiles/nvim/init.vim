syntax enable                               " enables syntax highlight

" ###### ets ######

set nocompatible                            " disable compatibility to old time vi

set ignorecase                              " enables case insensitivity

set hidden                                  " opening a new file when current buffer has unsaved changes causes files to be hidden, not closed

set mouse=v                                 " paste with middleclick

set autoindent                              " enables auto-indenting (a new line starts at the same indentation)
filetype plugin indent on                   " allow auto-indenting based on file type
set number relativenumber                   " enables number bar with line numbers relative to current line
set showcmd                                 " enables partial commands in bottom line
set cursorline                              " highlights current line
highlight Cursorline cterm=NONE ctermbg=darkblue ctermfg=white                                       
                                            " changes how cursorline is styled

set tabstop=2 shiftwidth=2 softtabstop=4 expandtab 
                                            " converts tabs -> spaces, defaults to 2 space tabs, and sets 2 space default for reindents
set list                                    " shows spaces, tabs, etc.
set listchars=eol:↪,tab:--                  " sets the eol and tab characters

set lazyredraw                              " doesn't redraw when executing macros, etc.
set ttyfast                                 " sends commands faster

set wildmenu                                " sets a horizontal strip to navigate through menus (and can use left/right to navigate)
set showmatch                               " highlights open and close containers

set incsearch                               " jumps to next logical match as you type with search (/)
set hlsearch                                " highlights all found items once search command is finished

set backspace=indent,eol,start              " allows you to <BS> through indentation, across eols, and past the start of your insert

set cmdheight=2                             " Gives more space for displaying messages

set updatetime=300                          " updates nvim faster
set shortmess+=c                            " doesn't pass messages to |ins-completion-menu|
set signcolumn=number                       

set statusline+=%F                          " Adds current full path to status line

" ######                         " Adds current full path to status line remaps ######

let mapleader=","                           " sets the vim leader key to ,
nnoremap <leader><space> :nohlsearch<CR>    " turns off search highlighting with <leader><space> in normal mode, no recursion

noremap <C-v> <C-w>v                        " maps opening a (vertical) new pane in normal mode to Ctrl-v 
noremap <C-s> <C-w>s                        " maps opening a (horizontal) new pane in normal mode to Ctrl-s 
noremap <C-j> <C-w>j                        " maps navigating down a pane in normal mode to Ctrl-j
noremap <C-k> <C-w>k                        " maps navigating up a pane in normal mode to Ctrl-k
noremap <C-h> <C-w>h                        " maps navigating left a pane in normal mode to Ctrl-h
noremap <C-l> <C-w>l                        " maps navigating right a pane in normal mode to Ctrl-l

nnoremap <leader>sv :source $MYVIMRC<CR>    " source init.vim

inoremap <silent><expr> <c-space> coc#refresh() " something for coc

" ###### Plugs ######

call plug#begin("~/.vim/plugged")
  Plug 'tomasr/molokai'
  Plug 'mhinz/vim-startify'
  Plug 'scrooloose/nerdtree'
  Plug 'preservim/nerdcommenter'            " use leader c-space or ci to comment line
  Plug 'ryanoasis/vim-devicons'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'evanleck/vim-svelte'
  Plug 'pangloss/vim-javascript'
  Plug 'HerringtonDarkholme/yats.vim'
  Plug 'codechips/coc-svelte', {'do': 'npm install'}
  Plug 'neoclide/coc-solargraph'

call plug#end()

" ###### Settings ######

" Colorscheme
colorscheme molokai
let g:molokai_original = 1

" #### COC ####

" Use tab for trigger completion with characters ahead and navigate
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "<\TAB>" :
    \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

" Make <CR> auto-select the first completion item and notify to format on enter. Could be remapped by other plugins.

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" use [g and ]g to navigate diagnostics, and use :CocDiagnostics to get all diagnostics of current buffer in location list

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

"Highlight the symbol and its references when holding the cursor.

autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming

nmap <leader>rn <Plug>(coc-rename)

"  Formatting selected code.

xmap <leader>f <Plug>(coc-format selected)
nmap <leader>f <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

"Applying code action to selected region
"Example: `<leader>aap for current paragraph

xmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to current buffer
nmap <leader>ac <Plug>(coc-codeaction)
" Apply autofix to problem on current line
nmap <leader>qf <Plug>(coc-fix-current)

" Run code lens action on current line
nmap <leader>cl <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

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

let g:coc_global_extensions = [
      \ 'coc-svelte',
      \ 'coc-solargraph',
      \ ]
