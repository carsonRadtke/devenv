local vim = vim
local Plug = vim.fn['plug#']

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.expandtab = true
vim.opt.cursorline = true
vim.opt.showmatch = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.expandtab = true

vim.call('plug#begin')

Plug('junegunn/fzf', { ['do'] = function()
        vim.fn['fzf#install']()
end })
Plug('junegunn/fzf.vim')
Plug('neovim/nvim-lspconfig')
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
Plug('tpope/vim-fugitive')
Plug('vim-airline/vim-airline')

vim.call('plug#end')

require'lspconfig'.clangd.setup{
        cmd = { 'clangd', '-j4', '--header-insertion=never' }
}

vim.cmd('source ~/.config/nvim/colors.vim')
