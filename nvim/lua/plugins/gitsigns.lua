return {
  "lewis6991/gitsigns.nvim",
  as = "gitsigns",
  config = function()
    require("gitsigns").setup({
      signs = {
        add          = { text = '│' },
        change       = { text = '│' },
        delete       = { text = '│' },
        topdelete    = { text = '_' },
        changedelete = { text = '│' },
        untracked    = { text = '┆' },
      },
    })
  end
}
