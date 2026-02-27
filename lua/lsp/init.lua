-- LSP configuration for Neovim 0.11+
local mason_lspconfig = require('mason-lspconfig')

-- Setup Mason
mason_lspconfig.setup({
    ensure_installed = {
        'pyright',
        'ruff',
        'lua_ls',
        'jsonls',
        'bashls',
        'marksman',
        'ts_ls',
        'vue_ls',
    },
})

-- Common capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Common on_attach
local on_attach = function(_client, _bufnr)
    -- Keybindings are set in core/keymaps.lua
end

-- Configure servers with minimal settings
-- Servers installed via Mason, configured here

vim.lsp.config('pyright', {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                diagnosticMode = 'openFilesOnly',
                typeCheckingMode = 'basic',
                useLibraryCodeForTypes = true,
                diagnosticSeverityOverrides = {
                    reportUnusedVariable = 'warning',
                    reportMissingImports = 'warning',
                },
                exclude = { '**/__pycache__', '.git', '.venv', 'venv' },
            },
        },
    },
})

vim.lsp.config('ruff', {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        lint = { enable = true, select = { 'E', 'W', 'F', 'I', 'B', 'C4', 'UP' }, ignore = { 'E501' } },
        format = { enable = true },
        organizeImports = true,
        fixAll = true,
    },
})

vim.lsp.config('lua_ls', {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim' } },
            workspace = { library = vim.api.nvim_get_runtime_file('', true), checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
})

vim.lsp.config('jsonls', {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        json = {
            format = { enable = true },
            validate = { enable = true },
        },
    },
})

vim.lsp.config('bashls', {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        bashIde = {
            globPattern = '*@(.sh|.inc|.bash|.command)',
        },
    },
})

vim.lsp.config('marksman', {
    on_attach = on_attach,
    capabilities = capabilities,
})

-- Servers with separate config files (complex settings)
vim.lsp.config('ts_ls', {
    on_attach = on_attach,
    capabilities = capabilities,
    init_options = { hostInfo = 'neovim' },
    filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue' },
    root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
})

vim.lsp.config('vue_ls', {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { 'vue' },
    root_markers = { 'package.json' },
    init_options = {
        typescript = { tsdk = nil },
        vue = { hybridMode = true },
    },
})
