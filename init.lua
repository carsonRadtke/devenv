-- Better line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Better indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.opt.autoindent = true

-- Show invisible characters
vim.opt.list = true
vim.opt.listchars = { tab = '→ ', trail = '·', nbsp = '␣' }

-- Fix tmux warning
vim.opt.termguicolors = true

-- Persistent undo
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.local/share/nvim/undo"

-- Line wrap --
vim.opt.wrap = false

-- Enable mouse support
vim.opt.mouse = "a"

-- Better backspace behavior
vim.opt.backspace = { "indent", "eol", "start" }

-- Auto-reload files changed outside vim
vim.opt.autoread = true

-- Global keybindings
local keymap = vim.api.nvim_set_keymap

vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, {})

-- clangd configuration
vim.lsp.config.clangd = {
  cmd = {
    "clangd",
    "--background-index",
    "-j=6",
    "--log=verbose",
  },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
  root_markers = { 'compile_commands.json', '.clangd', '.git' },
  capabilities = vim.lsp.protocol.make_client_capabilities(),
}

-- Enable LSPs
vim.lsp.enable('clangd') -- C/C++
vim.lsp.enable('ty') -- Python

-- Basic LSP keymaps
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.name == 'clangd' then
      local opts = { buffer = args.buf }
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    end
  end,
})

-- Basic Telescope keymaps
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})

