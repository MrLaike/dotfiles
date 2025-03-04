return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    -- "3rd/image.nvim",
  },
  lazy = false,
  opts = {
    auto_clean_after_session_restore = true,
    close_if_last_window = false,
    enable_git_status = true,
    enable_diagnostics = true,
    sources = {
      "filesystem"
    },
    commands = {
      parent_or_close = function(state)
        local node = state.tree:get_node()
        if (node.type == "directory" or node:has_children()) and node:is_expanded() then
          state.commands.toggle_node(state)
        else
          require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
        end
      end,
      child_or_open = function(state)
        local node = state.tree:get_node()
        if node.type == "directory" or node:has_children() then
          if not node:is_expanded() then
            state.commands.toggle_node(state)
          else
            require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
          end
        else
          state.commands.open(state)
        end
      end,
      -- TODO: add undo removed file/dir
      trash = function(state, selected_nodes)
        local inputs = require("neo-tree.ui.inputs")
        local node = state.tree:get_node()
        if node.type == "message" then
          return
        end
        local _, name = require("neo-tree.utils").split_path(node.path)
        local msg = string.format("Are you sure you want to trash '%s'?", name)
        inputs.confirm(msg, function(confirmed)
          if not confirmed then
            return
          end
          vim.api.nvim_command("silent !mv " .. node.path .. " ~/Trash")
          require("neo-tree.sources.manager").refresh(state)
        end)
      end
    },
    renderers = {
      directory = {
        { "icon" },
        { "name", use_git_status_colors = false, },
        {
          'symlink_target',
          highlight = 'NeoTreeSymbolicLinkTarget',
        },
        { 'clipboard' },

        -- { "git_status", highlight = "NeoTreeDimText" },
      },
      file = {
        { 'indent' },
        { 'icon' },
        { 'name' },
        { "diagnostics" },
        {
          'symlink_target',
          highlight = 'NeoTreeSymbolicLinkTarget',
        },
        { 'clipboard' },
        { "git_status", highlight = "NeoTreeDimText" },
      }
    },
    window = {
      width = 40,
      mappings = {
--        ["<bs>"] = false,
        ["l"] = "child_or_open",
        ["h"] = "parent_or_close",
        ["s"] = "open_split",
        ["v"] = "open_vsplit",
        ["T"] = "trash",
        ["a"] = {"add", config = {show_path = "none"}}
      }
    },
    filesystem = {
      filtered_items = {
        visible = false,
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_hidden = false,
      },
      bind_to_cwd = false,
      hijack_netrw = true,
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,

      window = {
        fuzzy_finder_mappings = {
          ["<C-j>"] = "move_cursor_down",
          ["<C-k>"] = "move_cursor_up",
        },
      }
    },
    event_handlers = {
      {
        event = "file_open_requested",
        handler = function()
          require("neo-tree.command").execute({ action = "close" })
        end
      },
    }
  },
}
