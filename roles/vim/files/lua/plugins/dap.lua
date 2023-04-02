return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'theHamsta/nvim-dap-virtual-text',
      'rcarriga/nvim-dap-ui',
    },
    config = function ()
      local dap = require('dap')

      local function map(mode, lhs, rhs, opts)
        opts = opts or {}
        opts.silent = true
        _G.map(mode, lhs, rhs, opts)
      end

      require("nvim-dap-virtual-text").setup()
      require("dapui").setup()

      map('n', '<F5>', dap.continue, { desc = "Debug continue" })
      map('n', '<F10>', dap.step_over, { desc = "Debug step over" })
      map('n', '<F11>', dap.step_into, { desc = "Debug step into" })
      map('n', '<F12>', dap.step_out, { desc = "Debug step out" })

      map('n', '<leader>b', function() dap.toggle_breakpoint() end, { desc = "Toggle breakpoint" })
      map('n', '<leader>B', function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, { desc = "Set condition point" })
      map('n', '<leader>lp', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, { desc = "Set log point" })
      map('n', '<leader>dr', dap.repl.open, { desc = "Debug open REPL" })
      map('n', '<leader>dl', dap.run_last, { desc = "Debug run last" })

      -- Rust Debugging
      dap.adapters.lldb = {
        type = 'executable',
        command = '/usr/bin/lldb-vscode', -- adjust as needed, must be absolute path
        name = 'lldb'
      }

      dap.configurations.cpp = {
        {
          name = 'Launch',
          type = 'lldb',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          args = {},
        },
      }

      dap.configurations.c = dap.configurations.cpp
      dap.configurations.rust = dap.configurations.cpp

      local base_path = vim.fn.stdpath('data') .. '/mason/'

      -- NodeJS config
      dap.adapters.node2 = {
        type = 'executable',
        command = 'node',
        args = { base_path .. 'vscode-node-debug2/out/src/nodeDebug.js' },
      }
      dap.adapters.chrome = {
        type = "executable",
        command = "node",
        args = { base_path .. 'vscode-chrome-debug/out/src/chromeDebug.js' },
      }
      dap.adapters.firefox = {
        type = 'executable',
        command = 'node',
        args = { base_path .. 'vscode-firefox-debug/dist/adapter.bundle.js' },
      }

      dap.configurations.typescript = {
        name = 'Debug with Firefox',
        type = 'firefox',
        request = 'launch',
        reAttach = true,
        url = 'http://localhost:3000',
        webRoot = '${workspaceFolder}',
        firefoxExecutable = '/usr/bin/firefox'
      }
      dap.configurations.javascriptreact = { -- change this to javascript if needed
        {
          type = "chrome",
          request = "attach",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = "inspector",
          port = 9222,
          webRoot = "${workspaceFolder}"
        }
      }

      dap.configurations.typescriptreact = { -- change to typescript if needed
        {
          type = "chrome",
          request = "attach",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = "inspector",
          port = 9222,
          webRoot = "${workspaceFolder}"
        }
      }
      dap.configurations.javascript = {
        {
          name = 'Launch',
          type = 'node2',
          request = 'launch',
          program = '${file}',
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = 'inspector',
          console = 'integratedTerminal',
        },
      }
    end
  },
}
