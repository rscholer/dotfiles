" Copyright (c) 2018 Raphael Scholer
"
" Permission is hereby granted, free of charge, to any person obtaining a copy
" of this software and associated documentation files (the "Software"), to deal
" in the Software without restriction, including without limitation the rights
" to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
" copies of the Software, and to permit persons to whom the Software is
" furnished to do so, subject to the following conditions:
"
" The above copyright notice and this permission notice shall be included in
" all copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
" IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
" FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
" AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
" LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
" OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
" THE SOFTWARE.

"""""""""""""""""""""""""
" Environmental variables
"""""""""""""""""""""""""
if empty($XDG_CACHE_HOME)
	let $XDG_CACHE_HOME = $HOME . '/.cache'
endif
if empty($XDG_CONFIG_HOME)
	let $XDG_CONFIG_HOME = $HOME . '/.config'
endif
if empty($XDG_DATA_HOME)
	let $XDG_DATA_HOME = $HOME . '/.local/share'
endif

"""""""""""""""""
" Source drop-ins
"""""""""""""""""
source $XDG_CONFIG_HOME/nvim/functions.vim
source $XDG_CONFIG_HOME/nvim/plugins.vim

""""""""""""""""""
" General settings
""""""""""""""""""
colorscheme distinguished
set background=dark
set nobackup
set noswapfile
set spelllang=en
set undolevels=1000  " Max. number of changes that can be undone
set undoreload=1000  " Max. number of lines to save for undo on a buffer reload.

"""""""""""""""""""""""
" Text editing settings
"""""""""""""""""""""""
set formatoptions-=t  " Disable insertion of newlines when exceeding textwidth
set inccommand=split
set shiftwidth=4
set softtabstop=4
set tabstop=4
set textwidth=79
set updatetime=250

"""""""""""""
" UI settings
"""""""""""""
set guicursor=
set colorcolumn=+1
set cursorline
set listchars=tab:\│\ ,trail:·,extends:»,precedes:«,eol:¶,nbsp:█
set number
set relativenumber
set scrolloff=5  " Keep n lines above/under cursor.
set sidescrolloff=5  " Keep n columns left/right of cursor.
set title

"""""""""""""""""
" Plugin settings
"""""""""""""""""
let g:SimpylFold_docstring_preview=1
let g:SimpylFold_fold_docstring=0
let g:SimpylFold_fold_import=0
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_theme="distinguished"
let g:markdown_enable_spell_checking=0
let g:markdown_folding_disabled=1
let g:python_highlight_all=1
let g:vim_markdown_folding_disabled=1
let g:xml_syntax_folding=1

""""""""""""""""""""""""""
" General autocmd settings
""""""""""""""""""""""""""
autocmd BufWritePre * :call StripTrailingWhitespace()

"""""""""""""
" Keybindings
"""""""""""""
" Set <leader>
let g:mapleader=','
let mapleader=','

" Don't move cursor when repeating last command with '.'.
nmap . .`[

" Easy use of tabs
nmap <leader>tc :tabclose<CR>
nmap <leader>tn :tabnext<CR>
nmap <leader>to :tabopen<CR>
nmap <leader>tp :tabprevious<CR>

" Toggle folds
noremap <space> za

" Toggle paste mode
nmap <silent><leader>pm :set paste!<BAR>:silent set paste?<CR>

" Quick close of nvim.
nmap <leader>q :quit<CR>

" Quick save of files.
nmap <leader>w :write<CR>

" Clear the search register.
nmap <silent><leader>/ :nohlsearch<CR>

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
nnoremap <leader>nc <C-w>v<C-w>l

" Jump to matching pairs easily.
nnoremap <Tab> %

" Toggle 'set list'
nmap <silent><leader>l :set list!<CR>

" Don't use ex mode
nnoremap Q gq

" Copy to clipboard
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
vnoremap  <leader>y  "+y

" Paste from clipboard
nnoremap <leader>P "+P
nnoremap <leader>p "+p
vnoremap <leader>P "+P
vnoremap <leader>p "+p
