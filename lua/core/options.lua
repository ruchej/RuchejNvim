-- Basic Neovim options
local opt = vim.opt
local wo = vim.wo

-- Indentation (4 spaces)
local indent = 4
opt.tabstop = indent
opt.softtabstop = indent
opt.shiftwidth = indent
opt.expandtab = true
opt.smartindent = true

-- Line numbers
wo.number = true
wo.relativenumber = true

-- Cursor and scrolling
wo.cursorline = true
opt.scrolloff = 7

-- Mouse support
opt.mouse = 'a'

-- Clipboard
opt.clipboard = 'unnamedplus'

-- Encoding
opt.encoding = 'utf-8'
opt.fileformat = 'unix'

-- Search
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- Window splitting
opt.splitright = true
opt.splitbelow = true

-- Folding
opt.foldmethod = 'indent'
opt.foldlevelstart = 99

-- Completion
opt.completeopt = 'menuone,noselect'
opt.wildmenu = true
opt.path = '**'

-- Statusline
opt.statusline = '%{expand("%:~:.")} %h%w%m%r %=%(%l,%c%V %= %P%)'

-- Russian keyboard layout
opt.langmap =
[[ёйцукенгшщзхъфывапролджэячсмитьбю;`qwertyuiop[]asdfghjkl\;'zxcvbnm\,.,ЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ;QWERTYUIOP{}ASDFGHJKL:\"ZXCVBNM<>]]

-- Set leader key
vim.g.mapleader = ' '

-- Disable swap file
opt.swapfile = false

-- Enable syntax highlighting
vim.cmd('syntax enable')
vim.cmd('filetype plugin indent on')

-- Colorscheme (загружается после lazy.nvim в plugins/init.lua)
-- vim.cmd('colorscheme gruvbox')
