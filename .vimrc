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
set cursorline

set nowrap

set backspace=indent,eol,start

set colorcolumn=88

call plug#begin()
    Plug 'prabirshrestha/vim-lsp'
    Plug 'mattn/vim-lsp-settings'
    Plug 'vim-airline/vim-airline'
    Plug 'tpope/vim-fugitive'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim' 
call plug#end()

nmap <buffer> gd <plug>(lsp-definition)
nmap <buffer> g[ <plug>(lsp-previous-diagnostic)
nmap <buffer> g] <plug>(lsp-next-diagnostic)

nmap <buffer> gn :bnext<cr>
nmap <buffer> gb :bprevious<cr>

nmap gf :call fzf#run({'source': 'git ls-files', 'sink': 'e', 'right': '50%'})<cr>
nmap gb :call fzf#run({'source': map(copy(getbufinfo()), 'v:val.name'), 'sink': 'e', 'right': '50%'})<cr>

