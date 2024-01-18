colorscheme default 
syntax on

set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4

filetype indent on
set ai
set si

set relativenumber
set number

set nowrap

set backspace=indent,eol,start

set colorcolumn=80

call plug#begin()
    Plug 'prabirshrestha/vim-lsp'
    Plug 'mattn/vim-lsp-settings'
    Plug 'vim-airline/vim-airline'
call plug#end()

nmap <buffer> gd <plug>(lsp-definition)
nmap <buffer> g[ <plug>(lsp-previous-diagnostic)
nmap <buffer> g] <plug>(lsp-next-diagnostic)

nmap <buffer> gn :bnext<cr>
nmap <buffer> gb :bprevious<cr>

