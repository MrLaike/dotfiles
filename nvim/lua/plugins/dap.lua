return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
    {
      "jay-babu/mason-nvim-dap.nvim",
      opt = {
        ensure_installed = { "php" }
      }
    },
    {
      "theHamsta/nvim-dap-virtual-text",
      opt = {
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = false,
        all_frames = true,
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
    vim.fn.sign_define("DapBreakpoint", { text="", texthl="DapBreakpoint", linehl="DapBreakpoint", numhl="DapBreakpoint" })
    vim.fn.sign_define("DapBreakpointCondition", { text="ﳁ", texthl="DapBreakpoint", linehl="DapBreakpoint", numhl="DapBreakpoint" })
    vim.fn.sign_define("DapBreakpointRejected", { text="", texthl="DapBreakpoint", linehl="DapBreakpoint", numhl= "DapBreakpoint" })
    vim.fn.sign_define("DapLogPoint", { text="", texthl="DapLogPoint", linehl="DapLogPoint", numhl= "DapLogPoint" })
    vim.fn.sign_define("DapStopped", { text="", texthl="DapStopped", linehl="DapStopped", numhl= "DapStopped" })
  end,
  config = function()
    require("dapui").setup({
      controls = {
        element = "repl",
        enabled = false,
      },
      element_mappings = {},
      expand_lines = true,
      floating = {
        border = "single",
        mappings = {
          close = { "q", "<Esc>" }
        }
      },
      force_buffers = true,
      icons = {
        collapsed = " ",
        current_frame = " ",
        expanded = " "
      },
      layouts = {
        {
          elements = {
            {
              id = "scopes",
              size = 0.25
            },
            {
              id = "breakpoints",
              size = 0.25
            }, {
              id = "stacks",
              size = 0.25
            }, {
              id = "watches",
              size = 0.25
            }
          },
          position = "left",
          size = 40
        }
      },
      mappings = {
        edit = "e",
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        repl = "r",
        toggle = "t"
      },
      render = {
        indent = 1,
        max_value_lines = 100
      }
    })
    local dap, dapui = require("dap"), require("dapui")

    -- TODO change path to vscode-php-debug
    dap.adapters.php = {
      type = "executable",
      command = "node",
      args = { "/home/mrlaike/vscode-php-debug/out/phpDebug.js" },
    }

    dap.configurations.php = {
      {
        type = "php",
        request = "launch",
        name = "Docker Xdebug",
        pathMappings = {
          ["/var/www/bitrix"] = "${workspaceFolder}";
        },
        proxy = {
          host = "host.docker.internal",
          port = 9003,
          idekey = "PHPSTORM"

        }
      },
      {
        type = "php",
        name = "Local Xdebug",
        request = "launch",
        port = 9003
      }
    }

    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = vim.fn.exepath("codelldb"),
        args = {"--port", "${port}"},
      }
    }

    dap.configurations.c = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      },
    }

    dap.configurations.rust = dap.configurations.c
    dap.configurations.cpp = dap.configurations.c

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

