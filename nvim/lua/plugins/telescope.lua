return   {
  "nvim-telescope/telescope.nvim", tag = "0.1.5",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "BurntSushi/ripgrep",
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        enabled = vim.fn.executable "make" == 1,
        build = "make",
        config = function()
            require("telescope").load_extension("fzf")
        end,
    },
    {
        "nvim-telescope/telescope-frecency.nvim",
        config = function()
            require("telescope").load_extension("frecency")
        end,
    },
  },
  config = function()
    local actions = require("telescope.actions");
    require("telescope").setup({
      defaults = {
        vimgrep_arguments = {
          'rg',
          '-i',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '-u'
        },
        layout_config = {
          horizontal = {
            size = {
              width = "90%",
              height = "60%",
            },
          },
          vertical = {
            size = {
              width = "90%",
              height = "90%",
            },
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
        find_files = {
          --theme = "cursor",
          prompt_prefix=" >",
          find_command = {"ag", "-i", "--silent", "--follow", "-g", "", "--literal", "--hidden", "--ignore", ".git "},
          on_complete = {
            function(picker)
              local index = 0
              for _ in picker.manager:iter() do
                index = index + 1
                if index > 1 then
                  break
                end
              end
            end
          }
        },
        live_grep = {
          prompt_prefix="🔍",
          find_command = {"rg", "-i", "--silent", "-u", "--ignore-file", ".ignore", "--follow", "-g", "", "--literal", "--hidden","-ignore", ".git "}
        },
        grep_string = {
          prompt_prefix="🔍",
          find_command = {"rg", "-i", "--silent", "--follow", "-g", "", "--literal", "--hidden","--ignore", ".git "}
        },

        frecency = {
          prompt_prefix="🔍",
          find_command = {"ag", "-i", "--silent", "--follow", "-g", "", "--literal", "--hidden", "--ignore", ".git "}
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
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          override_live_grep_sorter = true,
          case_mode = "smart_case",
        },
        frecency = {
          auto_validate = true,
          matcher = "fuzzy",
          path_display = { "filename_first" },
          default_workspace = "CWD",
          smartcase = "ON",
        },
      }
    })
  end
}
