-- Key mappings
local km = vim.keymap.set

-- === General ===
-- Clear search highlight
km('n', ',<space>', '<cmd>noh<cr>', { desc = 'Clear search highlight' })

-- Escape from insert mode with jk
km('i', 'jk', '<Esc>', { desc = 'Exit insert mode' })

-- Toggle fold with double space (like old config)
km('n', '<space><space>', 'za', { desc = 'Toggle fold' })

-- === Buffer management ===
local func = require('core.functions')

-- Next buffer
km('n', 'gn', function() func.next_buffer() end, { desc = 'Next buffer' })

-- Previous buffer
km('n', 'gp', function() func.prev_buffer() end, { desc = 'Previous buffer' })

-- Close buffer using Bclose (from bclose.vim plugin)
km('n', 'gw', '<cmd>Bclose<cr>', { desc = 'Close buffer' })

-- === Neo-tree file explorer ===
km('n', '<C-n>', '<cmd>Neotree toggle<cr>', { desc = 'Toggle Neo-tree' })

-- === Markdown preview ===
km('n', '<C-p>', '<cmd>MarkdownPreviewToggle<cr>', { desc = 'Toggle Markdown preview' })

-- === FZF Lua (fuzzy finder) - lazy load ===
km('n', '<leader>ff', function() require('fzf-lua').files() end, { desc = 'Find files' })
km('n', '<leader>fg', function() require('fzf-lua').live_grep() end, { desc = 'Live grep' })
km('n', '<leader>fb', function() require('fzf-lua').buffers() end, { desc = 'Buffers' })
km('n', '<leader>fh', function() require('fzf-lua').helptags() end, { desc = 'Help tags' })
km('n', '<leader>fm', function() require('fzf-lua').keymaps() end, { desc = 'Keymaps' })
km('n', '<leader>fr', function() require('fzf-lua').recent() end, { desc = 'Recent files' })
km('n', '<leader>fc', function() require('fzf-lua').commands() end, { desc = 'Commands' })

-- === LSP ===
-- Diagnostics
km('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostics' })
km('n', ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = 'Next diagnostic' })
km('n', '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = 'Previous diagnostic' })
km('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Add diagnostics to loclist' })

-- LSP navigation
km('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })
km('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
km('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to implementation' })
km('n', 'gr', vim.lsp.buf.references, { desc = 'Show references' })
km('n', 'K', vim.lsp.buf.hover, { desc = 'Hover documentation' })
km('n', '<C-k>', vim.lsp.buf.signature_help, { desc = 'Signature help' })

-- LSP actions
km('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename symbol' })
km('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code action' })

-- Format buffer with file-type specific settings
km('n', '<leader>f', function()
    local ft = vim.bo.filetype

    if ft == 'python' then
        -- Python: use external ruff command (format + organize imports + fix)
        vim.cmd('silent !ruff format %')
        vim.cmd('silent !ruff check --fix %')
        vim.cmd('silent edit!')
    elseif ft == 'json' or ft == 'jsonc' then
        -- JSON: use jq for consistent 2-space formatting
        vim.cmd('silent !jq --indent 2 . % > /tmp/nvim_json_fmt && mv /tmp/nvim_json_fmt %')
        vim.cmd('silent edit!')
    elseif ft == 'typescript' or ft == 'typescriptreact' then
        -- TypeScript: use LSP formatting (ts_ls) - SAFE, understands TS syntax
        vim.lsp.buf.format({ async = true })
    elseif ft == 'javascript' or ft == 'javascriptreact' then
        -- JavaScript: use prettier from project directory (finds .prettierrc)
        local prettier = vim.fn.executable('prettier')
        if prettier == 1 then
            local file_dir = vim.fn.expand('%:p:h')
            vim.cmd('silent !cd ' .. file_dir .. ' && prettier --write %')
            vim.cmd('silent edit!')
        else
            vim.lsp.buf.format({ async = true })
        end
    elseif ft == 'vue' then
        -- Vue: use LSP formatting (vue_ls + ts_ls) - SAFE
        vim.lsp.buf.format({ async = true })
    elseif ft == 'lua' then
        -- Lua: use stylua if available, otherwise LSP
        local stylua = vim.fn.executable('stylua')
        if stylua == 1 then
            vim.cmd('silent !stylua %')
            vim.cmd('silent edit!')
        else
            vim.lsp.buf.format({ async = true })
        end
    elseif ft == 'yaml' or ft == 'markdown' or ft == 'css' or ft == 'scss' or ft == 'less' or ft == 'html' then
        -- YAML/Markdown/CSS/SCSS/Less/HTML: use prettier if available
        local prettier = vim.fn.executable('prettier')
        if prettier == 1 then
            local file_dir = vim.fn.expand('%:p:h')
            vim.cmd('silent !cd ' .. file_dir .. ' && prettier --write %')
            vim.cmd('silent edit!')
        else
            vim.lsp.buf.format({ async = true })
        end
    else
        -- Default: use LSP formatting
        vim.lsp.buf.format({ async = true })
    end
end, { desc = 'Format buffer' })

-- Alternative: force ruff format for Python
km('n', '<leader>rf', function()
    vim.cmd('silent !ruff format %')
    vim.cmd('silent !ruff check --fix %')
    vim.cmd('silent edit!')
end, { desc = 'Ruff format (external)' })

km('n', '<leader>D', vim.lsp.buf.type_definition, { desc = 'Go to type definition' })

-- === Python DAP (debugger) ===
km('n', '<leader>b', function() require('dap').toggle_breakpoint() end, { desc = 'Toggle breakpoint' })
km('n', '<F9>', function() require('dap').continue() end, { desc = 'Start/Continue debugging' })
km('n', '<F8>', function() require('dap').step_over() end, { desc = 'Step over' })
km('n', '<F7>', function() require('dap').step_into() end, { desc = 'Step into' })
km('n', '<M-F8>', function() require('dap').repl.open() end, { desc = 'Open REPL' })
km('n', '<leader>di', function() require('dap.ui.variables').hover() end, { desc = 'Hover variable' })
km('v', '<leader>di', function() require('dap.ui.variables').visual_hover() end, { desc = 'Visual hover variable' })
km('n', '<leader>dui', function() require('dapui').toggle() end, { desc = 'Toggle DAP UI' })

-- === Git (gitsigns) ===
-- Lazy load gitsigns for keymaps
km('n', '<leader>hn', function() require('gitsigns').nav_hunk('next') end, { desc = 'Next git hunk' })
km('n', '<leader>hp', function() require('gitsigns').nav_hunk('prev') end, { desc = 'Previous git hunk' })
km('n', '<leader>hv', function() require('gitsigns').preview_hunk() end, { desc = 'Preview git hunk' })
km('n', '<leader>td', function() require('gitsigns').preview_hunk_inline() end, { desc = 'Preview inline diff' })
km('n', '<leader>gb', function() require('gitsigns').blame_line() end, { desc = 'Git blame line' })
