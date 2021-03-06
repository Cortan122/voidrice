runtime! archlinux.vim

" fancy cursors
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

set viminfo+=n~/.config/viminfo

syntax on
set encoding=utf-8
set tabstop=2
set number relativenumber
set visualbell
set t_vb=
set bg=light
set go=a
set mouse=a
set nohlsearch
set showcmd

nnoremap q :q<CR>
nnoremap <C-s> :w<CR>
nnoremap <C-Z> u
nnoremap <C-Y> <C-R>

inoremap <C-s> <C-O>:w<CR>
inoremap <C-Z> <C-O>u
inoremap <C-Y> <C-O><C-R>
