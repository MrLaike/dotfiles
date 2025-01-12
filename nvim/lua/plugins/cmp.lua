return {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "tzachar/cmp-ai",
      "onsails/lspkind.nvim",
    },
    lazy = false,
    event = "InsertEnter",
    opts = function()
      local cmp = require("cmp")
      local snip_status_ok, luasnip = pcall(require, "luasnip")
      local lspkind_status_ok, lspkind = pcall(require, "lspkind")
      local border_opts = {
        border = "rounded",
        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
      }

      local function has_words_before()
        local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
      end

      return {
        preselect = cmp.PreselectMode.None,
        completion = {
          completeopt = 'menu,menuone,noinsert',
        },
        formatting = {
          format = function (entry, item)
            if lspkind_status_ok then
                return lspkind.cmp_format({
                    mode = 'symbol',
                    maxwidth = 50,
                    ellipsis_char = '...',
                    show_labelDetails = true,
                    symbol_map = {
                        HF = "",
                        Ollama = "",
                    }
                })(entry, item)
            else
                local menu_icon = {
                  nvim_lsp = 'λ',
                  luasnip = '⋗',
                  buffer = 'Ω',
                  path = '🖫',
                }
                local maxwidth = 80
                item.abbr = string.sub(item.abbr, 1, maxwidth)
                item.menu = menu_icon[entry.source.name]

                return item
            end

          end
        },
        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        duplicates = {
          nvim_lsp = 1,
          luasnip = 1,
          buffer = 1,
          path = 1,
        },
        experimental = {
          ghost_text = false,
        },

        confirm_opts = {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        window = {
          completion = cmp.config.window.bordered(border_opts),
          documentation = cmp.config.window.bordered(border_opts),
        },
        mapping = {
          ["<C-k>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
          ["<C-j>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
          ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
          ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
          ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
          ["<C-y>"] = cmp.config.disable,
          ["<C-e>"] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close() },
          ["<CR>"] = cmp.mapping.confirm { select = true },
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              local entry = cmp.get_selected_entry()
              if not entry then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
              else
                vim.cmd("let &undolevels = &undolevels")
                cmp.confirm()
              end
            elseif has_words_before() then
              vim.cmd("let &undolevels = &undolevels")
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ['<C-x>'] = cmp.mapping(
            cmp.mapping.complete({
              config = {
                sources = cmp.config.sources({
                  { name = 'cmp_ai' },
                }),
              },
            }), { 'i' }
          ),
        },
        sources = cmp.config.sources {
          { name = "nvim_lsp", priority = 1000 },
          { name = "luasnip", priority = 800 },
          { name = "buffer", priority = 500 },
          { name = "path", priority = 250 },
        },
      }
    end,
}
