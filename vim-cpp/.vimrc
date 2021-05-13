"######################
"### Basic settings ###
"######################

nnoremap <SPACE> <Nop>
let mapleader=" "

syntax on

set wildmenu
set wildmode=list:longest

set number
set relativenumber
set linebreak
set showbreak=+++
set showmatch
set visualbell

set hlsearch
set smartcase
set ignorecase
set incsearch

set autoindent
set shiftwidth=4
set smartindent
set smarttab
set softtabstop=4
set expandtab

set autoread
set ruler
set undolevels=1000
set backspace=indent,eol,start

set t_Co=256

set hidden
set splitbelow
set splitright

"Show line at 120 characters
:set colorcolumn=120

"Paste without automatic indendation
set pastetoggle=<F2>

"Disable q/Q commands to avoid using them by accident
map q <Nop>
map Q <Nop>

"No flashing window or beep
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

let g:tex_flavor='latex'

"Python execution on F9
nnoremap <silent> <F9> :!clear;python3 %<CR>

"Buffer shortcuts
map gn :bn<cr>
map gp :bp<cr>
map gd :bd<cr>

"Highlighted parenthesis color and search color
hi MatchParen cterm=bold ctermbg=none ctermfg=magenta
hi Search cterm=NONE ctermfg=darkred ctermbg=yellow

"###############
"### Plugins ###
"###############

call plug#begin('~/.vim/plugged')
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'danilo-augusto/vim-afterglow'
    Plug 'jackguo380/vim-lsp-cxx-highlight'
    Plug 'vim-scripts/AfterColors.vim'
    Plug 'bfrg/vim-cpp-modern'
    Plug 'tpope/vim-surround'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'embear/vim-uncrustify'
    Plug 'preservim/nerdtree'
call plug#end()


"#######################
"### Plugin settings ###
"#######################

"netrw (file explorer)
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_winsize = 15
let g:netrw_altv = 1
let g:netrw_list_hide = &wildignore

augroup netrw_mapping
    autocmd!
    autocmd filetype netrw call NetrwMapping()
augroup END

function! NetrwMapping()
    nnoremap <silent> <buffer> <c-l> :TmuxNavigateRight<CR>
endfunction

"Nerdtree
nnoremap <leader>m :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

"vim-cpp-modern
let g:cpp_attributes_highlight = 1

"Airline
let g:airline_powerline_fonts = 0
let g:airline#extensions#tabline#enabled = 1
set laststatus=2
let g:airline#extensions#whitespace#enabled = 0
let g:airline_theme = 'dark'

"Afterglow
let g:afterglow_blackout=1
let g:afterglow_italic_comments=1 
colorscheme afterglow

"vim-uncrustify
let g:uncrustify_command="/home/tobias/.config/uncrustify/uncrustify/build/uncrustify"
let g:uncrustify_config_file="/home/tobias/.config/uncrustify/code_style.cfg"
autocmd BufWritePre * if (&filetype == 'cpp') | call Uncrustify() | endif

"CoC
let g:coc_global_extensions = ['coc-clangd', 'coc-pairs', 'coc-pyright', 'coc-sh', 'coc-json', 'coc-yaml']
set updatetime=300
set shortmess+=c
if has("patch-8.1.1564")
  set signcolumn=number
else
  set signcolumn=yes
endif

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

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

autocmd CursorHold * silent call CocActionAsync('highlight')

if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

command! -nargs=0 Format :call CocAction('format')
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

aug python
  au!
  au BufWrite *.py call CocAction('format')
aug END
