"Plugin manager (Pathogen)
execute pathogen#infect()
filetype plugin indent on

"Global vim config
syntax on

set wildmenu
set wildmode=list:longest

set number
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

"Paste without automatic indendation
set pastetoggle=<F2>

"Disable q/Q commands to avoid using them by accident
map q <Nop>
map Q <Nop>

"No flashing window or beep
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

let g:tex_flavor='latex'

"Colors
let g:afterglow_blackout=1
let g:afterglow_italic_comments=1 
colorscheme afterglow


let g:vimtex_view_general_viewer='okular'
let g:vimtex_view_general_options= '--unique @pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'

"Python execution on F9
nnoremap <silent> <F9> :!clear;python3 %<CR>

"Buffer shortcuts
map gn :bn<cr>
map gp :bp<cr>
map gd :bd<cr>

"Highlighted parenthesis color and search color
hi MatchParen cterm=bold ctermbg=none ctermfg=magenta
hi Search cterm=NONE ctermfg=darkred ctermbg=yellow

"Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
set laststatus=2
let g:airline#extensions#whitespace#enabled = 0
let g:airline_theme = 'dark'

"Nerdtree

autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-k> :NERDTreeToggle<cr>

"Tagbar
nmap <F8> :TagbarToggle<cr>
highlight TagbarHighlight guifg=Red ctermfg=Red

"CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_user_command = 'find %s -type f'

"Ultisnips
let g:UltiSnipsSnippetDirectories=["~/vim/bundle/vim-snippets/UltiSnips"]
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="horizontal"

"YouCompleteMe
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
let g:ycm_global_ycm_extra_conf = "~/.ycm_extra_conf.py"
let g:EclimCompletionMethod = 'omnifunc'
let g:ycm_autoclose_preview_window_after_insertion = 1
set completeopt-=preview
"autocmd FileType javascript setlocal omnifunc=tern#Complete
highlight YcmErrorSection ctermfg=red cterm=underline
"let g:ycm_python_binary_path = '/usr/bin/python3'
"let g:ycm_server_python_interpreter='/usr/bin/python3'
let g:ycm_python_interpreter_path = ''
let g:ycm_python_sys_path = []
let g:ycm_extra_conf_vim_data = [
  \  'g:ycm_python_interpreter_path',
  \  'g:ycm_python_sys_path'
  \]

