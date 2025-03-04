return   {
  "nvim-telescope/telescope.nvim", tag = "0.1.5",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "BurntSushi/ripgrep",
    {
      "danielfalk/smart-open.nvim",
      branch = "0.2.x",
      dependencies = {
        "kkharji/sqlite.lua",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      },
    },
    "nvim-telescope/telescope-live-grep-args.nvim" ,
  },
  keys = {
    {
      "<leader>sf",
      mode = { "n", "v" },
      function ()
        local get_selected_text = require('utils.functions').get_selected_text
        require("telescope").extensions.smart_open.smart_open({
          default_text= get_selected_text(),
          prompt_prefix=" ",
          previewer = false,
          layout_strategy = 'vertical',
          mirror = true,
          layout_config = {
          mirror = true,
            vertical = {
                width = 0.4,
                height = 0.6,
            }
          },
        })
      end,
      desc = "Search files"
    },
    {
      "<leader>sw",
      function ()
        require("telescope").extensions.live_grep_args.live_grep_args()
      end,
      desc = "Search words",
    },
    {
      '<leader>sb',
      '<cmd>Telescope buffers<CR>',
      desc = "Search words",
    },
    {
      '<leader>st',
      '<cmd>Telescope help_tags<CR>',
      desc = "Search words",
    }
  },
  config = function()
    local actions = require("telescope.actions");
    local get_selected_text = require('utils.functions').get_selected_text
    local lga_actions = require("telescope-live-grep-args.actions")

    require("telescope").setup({
      extensions = {
        smart_open = {
          cwd_only = true,
          filename_first = false,
          match_algorithm = "fzf"
        },
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          override_live_grep_sorter = true,
          case_mode = "smart_case",
        },
        live_grep_args = {
          auto_quoting = true,
          mappings = {
            i = {
              ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
              ["<C-space>"] = actions.to_fuzzy_refine,
            },
          },
          default_text = get_selected_text(),
          prompt_prefix="🔍",
        }
      },
      defaults = {
        vimgrep_arguments = {
          'rg',
          '-i',
          '--color=never',
          '--no-heading',
          "--ignore-file", ".ignore",
          '--with-filename',
          '--line-number',
          '--column',
          '-u'
        },
        layout_config = {
          horizontal = {
            width = 0.7,
            height = 0.6,
          },
          vertical = {
            width = 0.7,
            height = 0.6,
          }
        },
        mappings = {
          i = {
            ["<C-n>"] = actions.cycle_history_next,
            ["<C-p>"] = actions.cycle_history_prev,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous
          }
        },
        file_ignore_patterns = {
          "node_modules/.*",
          "%.env",
          "yarn.lock",
          "composer.lock",
          "package-lock.json",
          "lazy-lock.json",
          "init.sql",
          "target/.*",
          ".git/.*",
        },
      },
      pickers = {
        buffers = {
          default_text = get_selected_text(),
          sort_lastused = true,
          previewer = false,
          theme = 'dropdown',
        },
        live_grep = {
          default_text = get_selected_text(),
          prompt_prefix="🔍",
        },
      },
      preview = {
        filesize_limit = 10,
        mime_hook = function(filepath, bufnr, opts)
          local is_image = function(filepath)
            local image_extensions = {'png','jpg'}
            local split_path = vim.split(filepath:lower(), '.', {plain=true})
            local extension = split_path[#split_path]
            return vim.tbl_contains(image_extensions, extension)
          end
          if is_image(filepath) then
            local term = vim.api.nvim_open_term(bufnr, {})
            local function send_output(_, data, _ )
              for _, d in ipairs(data) do
                vim.api.nvim_chan_send(term, d..'\r\n')
              end
            end
            vim.fn.jobstart(
              {
                'catimg', filepath
              },
              {on_stdout=send_output, stdout_buffered=true, pty=true})
          else
            require("telescope.previewers.utils").set_preview_message(bufnr, opts.winid, "Binary cannot be previewed")
          end
        end
      },
      
    })
    require("telescope").load_extension("smart_open")
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("live_grep_args")

  end
}
