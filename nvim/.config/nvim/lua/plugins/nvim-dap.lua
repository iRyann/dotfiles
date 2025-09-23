-- lua/plugins/nvim-dap.lua
return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      -- Configuration UI
      dapui.setup()
      require("nvim-dap-virtual-text").setup()
      -- Auto-open/close UI
      dap.listeners.before.attach.dapui_config = function() dapui.open() end
      dap.listeners.before.launch.dapui_config = function() dapui.open() end
      dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
      dap.listeners.before.event_exited.dapui_config = function() dapui.close() end
      -- Configuration C/C++
      dap.adapters.cppdbg = {
        id = 'cppdbg',
        type = 'executable',
        command = vim.fn.stdpath("data") .. '/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7',
      }
      dap.configurations.c = {
        {
          name = "Launch file",
          type = "cppdbg",
          request = "launch",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = true,
        },
      }
      dap.configurations.cpp = dap.configurations.c
      -- Keymaps Debug améliorés
      vim.keymap.set("n", "<Leader>dc", dap.continue, { desc = "Debug: Continue" })
      vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
      vim.keymap.set("n", "<Leader>dso", dap.step_over, { desc = "Debug: Step Over" })
      vim.keymap.set("n", "<Leader>dsi", dap.step_into, { desc = "Debug: Step Into" })
      vim.keymap.set("n", "<Leader>dsq", dap.step_out, { desc = "Debug: Step Out" })
      vim.keymap.set("n", "<Leader>dr", dap.repl.open, { desc = "Debug: Open REPL" })
      vim.keymap.set("n", "<Leader>du", dapui.toggle, { desc = "Debug: Toggle UI" })
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    config = function()
      require("dap-python").setup("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")
    end
  }
}
