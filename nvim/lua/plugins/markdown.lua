return {
  "OXY2DEV/markview.nvim",
  lazy = true,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
    {
      "ekickx/clipboard-image.nvim",
      opts = {
        default = {
          img_dir = "img",
          img_dir_txt = "img",
          img_name = function () return os.date('%Y-%m-%d-%H-%M-%S') end,
          affix = "![](/%s)",
          img_handler = function (img)
            local script = string.format('~/bin/imgup %s &', img.path)
            os.execute(script)
          end
        },

        markdown = {
          img_dir = "img",
          img_dir_txt = "img",
          affix = "![](/%s)"
        }
      }
    }
  },
  opts = {
    buf_ignore = { "nofile" },
    debounce = 50,
    filetypes = { "markdown", "quarto", "rmd" },
    highlight_groups = "dynamic",
    hybrid_modes = nil,
    injections = {},
    initial_state = true,
    max_file_length = 1000,
    modes = { "n", "no", "c" },
    render_distance = 100,
    split_conf = {},

    block_quotes = {},
    callbacks = {},
    checkboxes = {},
    code_blocks = {},
    escaped = {},
    footnotes = {},
    headings = {},
    horizontal_rules = {},
    html = {},
    inline_codes = {},
    latex = {},
    links = {},
    list_items = {},
    tables = {}
  },
}
