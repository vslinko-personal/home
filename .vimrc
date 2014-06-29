"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NeoBundle configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif

call neobundle#begin(expand('~/.vim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'

" Languages
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'tpope/vim-haml'
NeoBundle 'groenewege/vim-less'
NeoBundle 'othree/html5.vim'
NeoBundle 'digitaltoad/vim-jade'
NeoBundle 'wavded/vim-stylus'
NeoBundle 'nginx.vim'
NeoBundle 'evidens/vim-twig'
NeoBundle 'mxw/vim-jsx'

" Completion
NeoBundle 'Shougo/neocomplcache.vim'
NeoBundle 'raimondi/delimitmate'
NeoBundle 'tpope/vim-abolish'

" Code display
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'nanotech/jellybeans.vim'

" Integrations
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'scrooloose/syntastic'

" Interface
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'bling/vim-airline'
NeoBundle 'myusuf3/numbers.vim'
NeoBundle 'MattesGroeger/vim-bookmarks'

" Commands
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'terryma/vim-multiple-cursors'

" Other
NeoBundle 'tpope/vim-sensible'

" end neobundle configuration
call neobundle#end()
filetype plugin indent on
NeoBundleCheck

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Bundles configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" nginx.vim
autocmd BufRead,BufNewFile *.conf setfiletype nginx

" Shougo/neocomplcache.vim
let g:neocomplcache_enable_at_startup = 1

" nathanaelkane/vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1

" nanotech/jellybeans.vim
syntax enable
set background=dark
colorscheme jellybeans
highlight ColorColumn ctermbg=darkgray

" scrooloose/syntastic
let g:syntastic_javascript_checkers = ['jsxhint']

" scrooloose/nerdtree
let g:NERDTreeIgnore = ['\.swp$']
let g:NERDTreeShowHidden = 1
autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" myusuf3/numbers.vim
set number

" Lokaltog/vim-easymotion
nnoremap s <Plug>(easymotion-s)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set colorcolumn=80
set cursorline
set expandtab
set list
set shiftwidth=2
set tabstop=2

let g:loaded_matchparen = 1

nnoremap <C-t> :NERDTreeToggle<CR>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap - <C-w>-
nnoremap = <C-w>+

nnoremap <Tab> >>
inoremap <Tab> <C-t>
vnoremap <Tab> >gv

nnoremap <S-Tab> <<
inoremap <S-Tab> <C-d>
vnoremap <S-Tab> <gv

autocmd BufRead,BufNewFile Vagrantfile set filetype=ruby
autocmd BufRead,BufNewFile Berksfile set filetype=ruby

autocmd BufWritePre * :%s/\s\+$//e

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
