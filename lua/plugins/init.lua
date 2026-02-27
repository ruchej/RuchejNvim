-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Load lazy.nvim and setup plugins
local lazy_ok, lazy = pcall(require, 'lazy')
if not lazy_ok then
    vim.notify('Failed to load lazy.nvim', vim.log.levels.ERROR)
    return
end

lazy.setup({
    -- Colorscheme
    { 'morhetz/gruvbox',         lazy = false,         priority = 1000 },

    -- Mason (only installs servers, not config)
    {
        'williamboman/mason.nvim',
        lazy = false,
        opts = {},
    },
    {
        'williamboman/mason-lspconfig.nvim',
        lazy = false,
        opts = {},
    },

    -- LSP
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
        },
        config = function() require('lsp') end,
    },

    -- Neo-tree
    {
        'nvim-neo-tree/neo-tree.nvim',
        branch = 'v3.x',
        cmd = 'Neotree',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
            'MunifTanjim/nui.nvim',
        },
        opts = {},
    },

    -- Gitsigns
    { 'lewis6991/gitsigns.nvim', event = 'BufReadPre', opts = {} },

    -- Bclose for buffer closing (загружается сразу для команды Bclose)
    { 'rbgrouleff/bclose.vim', lazy = false },

    -- CMP
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'saadparwaiz1/cmp_luasnip',
            'L3MON4D3/LuaSnip',
        },
        config = function() require('plugins.cmp') end,
    },

    -- Treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        event = 'BufReadPost',
        opts = {
            ensure_installed = { 'python', 'lua', 'bash', 'json', 'yaml', 'markdown', 'markdown_inline' },
            highlight = { enable = true },
        },
    },

    -- DAP
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            'mfussenegger/nvim-dap-python',
            'rcarriga/nvim-dap-ui',
            'nvim-neotest/nvim-nio',
        },
        config = function() require('plugins.dap') end,
    },

    -- FZF Lua (fuzzy finder)
    {
        'ibhagwan/fzf-lua',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        cmd = 'FzfLua',
        opts = {},
    },

    -- Markdown preview
    {
        'iamcco/markdown-preview.nvim',
        cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
        build = 'cd app && npm install',
        init = function()
            vim.g.mkdp_filetypes = { 'markdown' }
        end,
        ft = { 'markdown' },
    },
}, {
    install = { colorscheme = { 'gruvbox' } },
    checker = { enabled = false }, -- Отключить автопроверку обновлений
})

-- Colorscheme
pcall(function() vim.cmd('colorscheme gruvbox') end)

-- Keymaps
require('core.keymaps')

-- Plugin configs
require('plugins.neo-tree')
require('plugins.gitsigns')
