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
  require('plugins.todo'),
  require('plugins.markdown'),
  -- require('plugins.vimtex'),
  require('plugins.incline'),
  require('plugins.dadbod'),
  require('plugins.lualine'),
  require('plugins.gitsigns'),
  require('plugins.statuscol'),
  -- require('plugins.tiny-code-action'),
  require('plugins.tokionight'),
  require('plugins.neotest'),
  require('plugins.url-open'),
  require('plugins.windows'),
  require('plugins.harpoon'),
  -- require('plugins.align'),
  require('plugins.diagnostic-virtual-text'),
  {
    "SmiteshP/nvim-navic",
    dependencies = {
      "neovim/nvim-lspconfig"
    }
  },
  require('plugins.scrollbar'),
  -- require('plugins.laravel'),
  require('plugins.outline'),
  require('plugins.hop'),
  require('plugins.guess-indent'),
  require('plugins.vim-illuminate'),
  require('plugins.diffview'),
  require('plugins.undotree'),
  require('plugins.spellwarn'),
  -- { 'folke/which-key.nvim', },
  -- { 'preservim/nerdcommenter' },
  -- { 'numToStr/Comment.nvim' },
  require('plugins.colorizer'),
  -- {"xiyaowong/nvim-cursorword"},
  require('plugins.treesitter'),
  require('plugins.luasnip'),
  -- require('plugins.oil'), BUG: break neo-tree initialize
  require('plugins.ufo'),
  require('plugins.lspconfig'),
  require('plugins.cmp'),
  -- require('plugins.cmp-ai'),
  require('plugins.dap'),
  require('plugins.neo-tree'),
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
    },
  },
  {
    "HiPhish/rainbow-delimiters.nvim"
  },
}

require("lazy").setup(plugins)


