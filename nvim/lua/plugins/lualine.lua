return {
  "nvim-lualine/lualine.nvim",
  as = "lualine",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "arkav/lualine-lsp-progress"
  },
  config = function()
    local colors = require("wal-colors.core").ColorSpec.load()

    local theme = {
      normal = {
        a = { fg = colors.background:out(), bg = colors.color4:out() },
        b = { fg = colors.background:out(), bg = colors.foreground:out() },
        c = { fg = colors.foreground:out() },
      },

      insert = { a = { fg = colors.background:out(), bg = colors.color4:out() } },
      visual = { a = { fg = colors.background:out(), bg = colors.color5:out() } },
      replace = { a = { fg = colors.background:out(), bg = colors.color6:out() } },

      inactive = {
        a = { fg = colors.foreground:out(), bg = colors.background:out()},
        b = { fg = colors.foreground:out(), bg = colors.background:out()},
        c = { fg = colors.foreground:out() },
      },
    }

    require("lualine").setup {
      options = {
        icons_enabled = true,
        theme = theme,
        component_separators = "",
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        always_show_tabline = true,
        globalstatus = true,
        refresh = {
          statusline = 100,
          tabline = 100,
          winbar = 100,
        }
      },
      sections = {
        lualine_a = {{ "mode", separator = { left = "" }, padding = 2 }},
        lualine_b = {"branch", "diagnostics"},
        lualine_c = {
          {
            'filetype',
            colored = true,
            icon_only = true,
            padding = { left = 1 },
            icon = { align = 'right' }
          },
          {
            "filename",
            padding = 0,
            path = 1,
          },
          {
            "filesize",
            cond = function ()
               return (vim.fn.empty(vim.fn.expand('%:t')) ~= 1)
            end,
            padding = 1,
          }
        },
        lualine_x = {
          {
            function()
              local msg = 'No Active Lsp'
              local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
              local clients = vim.lsp.get_clients()
              if next(clients) == nil then
                return msg
              end
              for _, client in ipairs(clients) do
                local filetypes = client.config.filetypes
                if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                  return client.name
                end
              end
              return msg
            end,
            icon = ' LSP:',
          },
          {
            "lsp_progress",
            display_components = { 'spinner', { 'title', 'percentage', 'message' }},
            colors = {
              percentage  = colors.color2:out(),
              title  = colors.color2:out(),
              message  = colors.color2:out(),
              spinner = colors.color2:out(),
              lsp_client_name = colors.color4:out(),
              use = true,
            },
            separators = {
              component = ' ',
              progress = ' | ',
              message = { pre = '(', post = ')', commenced = 'In Progress', completed = 'Completed' },
              percentage = { pre = '', post = '%% ' },
              title = { pre = '', post = ': ' },
              lsp_client_name = { pre = '[', post = ']' },
              spinner = { pre = '', post = '' },
            },
            timer = { progress_enddelay = 500, spinner = 1000, lsp_client_name_enddelay = 1000 },
            spinner_symbols = { '🌑 ', '🌒 ', '🌓 ', '🌔 ', '🌕 ', '🌖 ', '🌗 ', '🌘 ' },
          },
          "encoding"},
        lualine_y = {"progress", "diff"},
        lualine_z = {{ "location", separator = { right = "" }, padding = 1 },}
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {"filename"},
        lualine_x = {"location"},
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {}
    }
  end
}
