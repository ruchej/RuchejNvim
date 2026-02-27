-- Neovim configuration for Python development
-- Minimal but functional config

--local conf_path = vim.fn.expand('$HOME/.config/RuchejNvim')
--package.path = string.format(
--    '%s;%s/lua/?.lua;%s/lua/?/init.lua',
--    package.path,
--    conf_path,
--    conf_path
--)

-- Load core settings (options and autocommands only)
require('core.options')
require('core.autocommands')

-- Load plugins (includes lazy.nvim setup, keymaps, and plugin configs)
require('plugins')
