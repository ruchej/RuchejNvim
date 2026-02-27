-- DAP configuration (Python debugger)
local dap = require('dap')
local dapui = require('dapui')

-- Setup DAP UI
dapui.setup({
  icons = {
    expanded = '▾',
    collapsed = '▸',
    current_frame = '🔵',
  },
  controls = {
    enabled = true,
    icons = {
      pause = '⏸',
      play = '▶',
      step_into = '↘',
      step_over = '➡',
      step_out = '↖',
      step_back = '⏪',
      run_last = '⏩',
      terminate = '⛔',
    },
  },
  layouts = {
    {
      elements = {
        { id = 'scopes', size = 0.25 },
        'breakpoints',
        'stacks',
        'watches',
      },
      size = 40,
      position = 'left',
    },
    {
      elements = {
        'repl',
        'console',
      },
      size = 0.25,
      position = 'bottom',
    },
  },
})

-- DAP UI auto open/close
dap.listeners.after.event_initialized.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

-- Setup Python debugger
-- Make sure to install debugpy: pip install debugpy
local python_path = vim.fn.exepath('python3') ~= '' and vim.fn.exepath('python3') or vim.fn.exepath('python')
if python_path ~= '' then
  require('dap-python').setup(python_path)
end

-- Default launch configuration
table.insert(dap.configurations.python, {
  type = 'python',
  request = 'launch',
  name = 'Launch file',
  program = '${file}',
  pythonPath = python_path,
})

-- Sign definitions for breakpoints
vim.fn.sign_define('DapBreakpoint', {
  text = '🔴',
  texthl = 'DapBreakpoint',
  linehl = 'DapBreakpoint',
  numhl = 'DapBreakpoint',
})
vim.fn.sign_define('DapStopped', {
  text = '⭐',
  texthl = 'DapStopped',
  linehl = 'DapStopped',
  numhl = 'DapStopped',
})
