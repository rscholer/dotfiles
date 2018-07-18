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

""""""""""""""""""""
" Configure vim-plug
""""""""""""""""""""
let g:plug_shallow=1

""""""""""""""""""""
" Bootstrap vim-plug
""""""""""""""""""""
if empty(glob($XDG_CONFIG_HOME . '/nvim/autoload/plug.vim'))
	silent !curl -fLo $XDG_CONFIG_HOME/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

""""""""""""""""
" Define plugins
""""""""""""""""
call plug#begin($XDG_DATA_HOME . '/nvim/plugged')
	Plug 'Matt-Deacalion/vim-systemd-syntax'
	Plug 'Vimjas/vim-python-pep8-indent'
	Plug 'airblade/vim-gitgutter'
	Plug 'cespare/vim-toml'
	Plug 'christoomey/vim-sort-motion'
	Plug 'deathlyfrantic/vim-distinguished'
	Plug 'farmergreg/vim-lastplace'
	Plug 'godlygeek/tabular' | Plug 'gabrielelana/vim-markdown'
	Plug 'jiangmiao/auto-pairs'
	Plug 'mitsuhiko/vim-rst'
	Plug 'tmhedberg/SimpylFold'
	Plug 'tmux-plugins/vim-tmux'
	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-fugitive'

	" Load always last
	Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
call plug#end()
