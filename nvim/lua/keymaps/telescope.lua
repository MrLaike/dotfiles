local keymap = require('utils.keymap')
local vkeymap = require('utils.vkeymap')
local telescope = require('telescope.builtin')

local cursor0;
local cursor;
local word;
local _last_picker = nil
local _last_ctx = nil
local ctx = nil

local function telescope_remember(func, ctxfunc)
  local function get_visual_selection()
    vim.cmd('noau normal! "vy"')
    local text = vim.fn.getreg('v')
    vim.fn.setreg('v', {})

    text = string.gsub(text, "\n", "")
    if #text > 0 then
      return text
    else
      return ''
    end
  end


  local function inner()
    if ctxfunc == nil then
      ctx = nil
    else
      ctx = ctxfunc()
    end
    if func == _last_picker and vim.deep_equal(ctx, _last_ctx) then
      telescope.resume()
    else
      _last_picker = func
      _last_ctx = ctx
      func({ default_text = get_visual_selection() })
    end
  end

  return inner
end


local function tokenctx()
  cursor0 = vim.api.nvim_win_get_cursor(0)
  vim.cmd.normal("lb")
  cursor = vim.api.nvim_win_get_cursor(0)
  word = vim.call('expand', '<cword>')
  vim.api.nvim_win_set_cursor(0, cursor0)
  return { cursor, word }
end

local function frecency()
  require("telescope").extensions.frecency.frecency {
    workspace = "CWD",
    path_display = { "filename_first" },
    startcase = 'ON',
  }
end

vim.keymap.set({ "n", "v" }, "<leader>sf", telescope_remember(telescope.find_files, tokenctx))
vim.keymap.set({ "n", "v" }, "<leader>sw", telescope_remember(telescope.live_grep, tokenctx))
vim.keymap.set('n', '<leader>sb', '<cmd>Telescope buffers<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>st', '<cmd>Telescope help_tags<CR>', { noremap = true, silent = true })
