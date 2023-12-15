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

call plug#begin()
    Plug 'prabirshrestha/vim-lsp'
    Plug 'mattn/vim-lsp-settings'
call plug#end()

function! s:on_lsp_buffer_enabled() abort
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> g[ <plug>(lsp-previous-diagnostic)
    nmap <buffer> g] <plug>(lsp-next-diagnostic)
endfunction
