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

-- Persistent undo
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.local/share/nvim/undo"

-- Enable mouse support
vim.opt.mouse = "a"

-- Better backspace behavior
vim.opt.backspace = { "indent", "eol", "start" }

-- Auto-reload files changed outside vim
vim.opt.autoread = true

