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
    { 'morhetz/gruvbox', lazy = false, priority = 1000 },

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
            'nvim-lua/plenary.nvim',
        },
        config = function() require('lsp') end,
    },

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

    -- Surround
    {
        'kylechui/nvim-surround',
        version = '^4.0.0',
        event = 'VeryLazy',
    },

    { 'easymotion/vim-easymotion' },

    -- Rainbow CSV (colorize CSV columns)
    {
        'mechatroner/rainbow_csv',
        ft = { 'csv', 'tsv' },
    },

    -- LazyGit (git TUI)
    {
        'kdheepak/lazygit.nvim',
        cmd = {
            'LazyGit',
            'LazyGitConfig',
            'LazyGitCurrentFile',
            'LazyGitFilter',
            'LazyGitFilterCurrentFile',
        },
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
    },

    -- Which-key (keymaps popup)
    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        opts = {
            plugins = { spelling = true },
            defaults = {},
            win = {
                border = 'rounded',
                padding = { 2, 2, 2, 2 },
            },
        },
    },

    -- Alpha dashboard
    {
        'goolord/alpha-nvim',
        lazy = false,
        priority = 100,
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function() require('plugins.dashboard') end,
    },

    -- Import other plugins from separate files
    { import = 'plugins.neo-tree' },
    { import = 'plugins.gitsigns' },
    { import = 'plugins.indent-blankline' },
}, {
    install = { colorscheme = { 'gruvbox' } },
    checker = { enabled = false }, -- Отключить автопроверку обновлений
})

-- Colorscheme
pcall(function() vim.cmd('colorscheme gruvbox') end)

-- Keymaps
require('core.keymaps')
