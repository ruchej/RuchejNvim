-- Buffer management functions
local M = {}

-- Следующий буфер
function M.next_buffer()
  vim.cmd('bnext')
end

-- Предыдущий буфер
function M.prev_buffer()
  vim.cmd('bprevious')
end

return M
