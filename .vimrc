" plugins
call pathogen#infect()

" environment
set colorcolumn=80
set cursorline
set list
set number
colorscheme jellybeans
highlight ColorColumn ctermbg=darkgray

" editor
set expandtab
set shiftwidth=2
set tabstop=2

" show hidden files in filesystem tree
let NERDTreeShowHidden=1

" disable matchparen plugin
let loaded_matchparen=1

" mappings
nmap <C-b> <Leader>ci
imap <C-b> <Esc><Leader>cili

nnoremap <C-t> :NERDTreeToggle<CR>

nnoremap <C-o> :set nonumber!<CR>

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

" set filetypes
autocmd BufRead,BufNewFile Vagrantfile set filetype=ruby
autocmd BufRead,BufNewFile Berksfile set filetype=ruby

" trim trailing spaces before save
autocmd BufWritePre * :%s/\s\+$//e

" open filesystem tree if vim opened without arguments
autocmd vimenter * if !argc() | NERDTree | endif

" close vim if opened only filesystem tree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
