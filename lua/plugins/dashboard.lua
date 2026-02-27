-- Alpha dashboard configuration
local alpha = require('alpha')
local dashboard = require('alpha.themes.dashboard')

-- Путь к конфигурации Neovim
local config_path = vim.fn.stdpath('config')

-- Заголовок RUCHEJ
dashboard.section.header.val = {
    '                                                   ',
    ' ██████╗ ██╗   ██╗ ██████╗██╗  ██╗███████╗     ██╗ ',
    ' ██╔══██╗██║   ██║██╔════╝██║  ██║██╔════╝     ██║ ',
    ' ██████╔╝██║   ██║██║     ███████║█████╗       ██║ ',
    ' ██╔══██╗██║   ██║██║     ██╔══██║██╔══╝  ██   ██║ ',
    ' ██║  ██║╚██████╔╝╚██████╗██║  ██║███████╗╚█████╔╝ ',
    ' ╚═╝  ╚═╝ ╚═════╝  ╚═════╝╚═╝  ╚═╝╚══════╝ ╚════╝  ',
    '                                                   ',
}

-- Кнопки меню
dashboard.section.buttons.val = {
    dashboard.button('n', '  Новый файл', '<cmd>ene<cr>'),
    dashboard.button('f', '  Найти файл', '<cmd>FzfLua files<cr>'),
    dashboard.button('r', '  Недавние', '<cmd>FzfLua oldfiles<cr>'),
    dashboard.button('g', '  Grep', '<cmd>FzfLua live_grep<cr>'),
    dashboard.button('s', '⚙️  Настройки', '<cmd>cd ' .. config_path .. '<CR><cmd>Neotree reveal<cr>'),
    dashboard.button('l', '󰒲  Lazy', '<cmd>Lazy<cr>'),
    dashboard.button('q', '  Выход', '<cmd>qa<cr>'),
}

-- Отступы
dashboard.config.layout = {
    { type = 'padding', val = 2 },
    dashboard.section.header,
    { type = 'padding', val = 2 },
    dashboard.section.buttons,
    { type = 'padding', val = 2 },
}

-- Закрыть Neo-tree при открытии dashboard
dashboard.config.opts.noautocmd = true

-- Footer со статистикой загрузки
vim.api.nvim_create_autocmd('User', {
    pattern = 'LazyVimStarted',
    callback = function()
        local stats = require('lazy').stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        dashboard.section.footer.val = '⚡ Загружено ' .. stats.count .. ' плагинов за ' .. ms .. 'ms'
        pcall(alpha.redraw)
    end,
})

alpha.setup(dashboard.config)

-- Запуск dashboard при открытии Neovim без файлов
vim.api.nvim_create_autocmd('VimEnter', {
    callback = function()
        -- Проверка: если нет файлов в аргументах и нет буферов
        if vim.fn.argc(-1) == 0 and #vim.api.nvim_list_bufs() == 1 then
            alpha.start('dashboard')
        end
    end,
})
