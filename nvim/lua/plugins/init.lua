local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  require('plugins.pywal'),
  require('plugins.telescope'),
  require('plugins.treesitter'),
  require('plugins.todo'),
  require('plugins.ai'),
  require('plugins.image'),
  require('plugins.ai-chat'),
  { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true, opts = ...},
  -- require('plugins.markdown'),
  -- require('plugins.vimtex'),
  -- require('plugins.incline'),
  require('plugins.dadbod'),
  require('plugins.lualine'),
  require('plugins.gitsigns'),
  -- require('plugins.muren'),
  {'mg979/vim-visual-multi'},
  require('plugins.statuscol'),
  -- require('plugins.tiny-code-action'),
  -- require('plugins.tokionight'),
  require('plugins.neotest'),
  require('plugins.url-open'),
  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    opts = {
      -- add options here
      -- or leave it empty to use the default settings
    },
    keys = {
      -- suggested keymap
      { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
    },
  },
  -- require('plugins.windows'),
  require('plugins.harpoon'),
  -- require('plugins.align'),
  -- require('plugins.diagnostic-virtual-text'),
  {
    "SmiteshP/nvim-navic",
    dependencies = {
      "neovim/nvim-lspconfig"
    }
  },
  require('plugins.surround'),
  require('plugins.scrollbar'),
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "rebelot/kanagawa.nvim" },
  { "sainnhe/everforest" },
  -- require('plugins.laravel'),
  require('plugins.outline'),
  require('plugins.hop'),
  require('plugins.guess-indent'),
  require('plugins.vim-illuminate'),
  require('plugins.diffview'),
  require('plugins.undotree'),
  require('plugins.spellwarn'),
  { 'folke/which-key.nvim', },
  -- { 'preservim/nerdcommenter' },
  -- { 'numToStr/Comment.nvim' },
  -- require('plugins.colorizer'),
  require('plugins.highlight-colors'),
  -- {"xiyaowong/nvim-cursorword"},
  require('plugins.luasnip'),
  require('plugins.oil'),
  require('plugins.ufo'),
  require('plugins.lspconfig'),
  require('plugins.cmp'),
  -- require('plugins.cmp-ai'),
  require('plugins.dap'),
  -- require('plugins.neo-tree'),
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
    },
  },
  { "HiPhish/rainbow-delimiters.nvim" }
}

require("lazy").setup(plugins)


