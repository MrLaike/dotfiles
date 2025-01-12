return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
    {
      "theHamsta/nvim-dap-virtual-text",
      opt = {
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
      },
      config = function ()
        require("nvim-dap-virtual-text").setup()
      end
    },
    {
      "leoluz/nvim-dap-go",
      ft = "go",
      dependencies = { "mfussenegger/nvim-dap" },
      opts = {
        delve = {
          detached = false,
        },
      },
      config = function(_, opts)
        require("dap-go").setup(opts)
        require("dap").set_log_level("TRACE")
      end,
    },

  },
  init = function()
    vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#993939", bg = "#31353f" })
    vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, fg = "#61afef", bg = "#31353f" })
    vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = "#98c379", bg = "#31353f" })

    vim.fn.sign_define("DapBreakpoint", { text="", texthl="DapBreakpoint", linehl="DapBreakpoint", numhl="DapBreakpoint" })
    vim.fn.sign_define("DapBreakpointCondition", { text="ﳁ", texthl="DapBreakpoint", linehl="DapBreakpoint", numhl="DapBreakpoint" })
    vim.fn.sign_define("DapBreakpointRejected", { text="", texthl="DapBreakpoint", linehl="DapBreakpoint", numhl= "DapBreakpoint" })
    vim.fn.sign_define("DapLogPoint", { text="", texthl="DapLogPoint", linehl="DapLogPoint", numhl= "DapLogPoint" })
    vim.fn.sign_define("DapStopped", { text="", texthl="DapStopped", linehl="DapStopped", numhl= "DapStopped" })
  end,
  config = function()
    local dap, dapui = require("dap"), require("dapui")
    dapui.setup()

    local widgets = require("dap.ui.widgets")


    dap.configurations.php = {
      {
        type = "php";
        request = "launch";
        name = "Launch file";
        hostname = "0.0.0.0";
        pathMapping = {{
          ["/var/www/html"] = vim.fn.getcwd() .. "/";
        }}
      }
    }

    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = "/home/mrlaike/.local/share/nvim/mason/bin/codelldb",
        args = {"--port", "${port}"},
      }
    }

    dap.configurations.c = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      },
    }

    dap.adapters.gdb = {
      type = "executable",
      command = "gdb",
      args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
    }

    dap.configurations.lua = {
      name = "Launch file";
      type = "local-lua";
      request = "launch";
      program = "${file}";
      phpPath = function()
        return "/usr/bin/php"
      end;
    }

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end
  end

}

