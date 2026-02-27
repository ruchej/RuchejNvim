-- Auto commands
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local my_group = augroup('MyAutoCommands', { clear = true })

-- 1. Show diagnostics on cursor hold
-- Показывает ошибки/предупреждения при остановке курсора
autocmd({ 'CursorHold', 'CursorHoldI' }, {
    group = my_group,
    callback = function()
        vim.diagnostic.open_float(nil, { focusable = false })
    end,
    desc = 'Show diagnostics on cursor hold',
})

-- 2. Auto resize windows on terminal resize
-- Автоматически выравнивает окна при изменении размера терминала
autocmd('VimResized', {
    group = my_group,
    callback = function()
        vim.cmd('wincmd =')
    end,
    desc = 'Auto resize windows',
})

-- 3. Restore cursor position on file open
-- Восстанавливает позицию курсора на месте последнего редактирования
autocmd('BufReadPost', {
    group = my_group,
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
    desc = 'Restore cursor position',
})

-- 4. Highlight yanked text
-- Подсвечивает скопированный текст на короткое время
autocmd('TextYankPost', {
    group = my_group,
    callback = function()
        vim.hl.on_yank({ higroup = 'IncSearch', timeout = 200 })
    end,
    desc = 'Highlight yanked text',
})
