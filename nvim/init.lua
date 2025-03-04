
require('plugins')
require('keymaps')

-- require('addition.open_current_dir')
-- We need to ensure that we are in the directory specified when opening the file
local group_cdpwd = vim.api.nvim_create_augroup("group_cdpwd", { clear = true })
vim.api.nvim_create_autocmd({"VimEnter", "BufEnter" }, {
    group = group_cdpwd,
    pattern = {"*"},
    callback = function()
        local current_dir = require('oil').get_current_dir()
        if type(current_dir) ~= 'string' then
            current_dir = vim.fn.expand('%:p:h')
        end
        vim.api.nvim_set_current_dir(current_dir)
    end,
    once = true,
})

-- Need for set lazy.nvim keys
require('telescope')

vim.cmd [[ 
hi DiagnosticUnderlineError guisp='Red' gui=undercurl
hi DiagnosticUnderlineWarn guisp='Yellow' gui=undercurl
hi DiagnosticUnderlineInfo guisp='Cyan' gui=undercurl
hi DiagnosticUnderlineHint guisp='Blue' gui=undercurl
set termguicolors
]]

vim.diagnostic.config({
    underline = true,
    virtual_text = false,
    -- virtual_text = { spacing = 1, prefix = "<-" },
    { virtual_lines = { only_current_line = true } },
    update_in_insert = false,
    severity_sort = true,
    float = {
        focusable = true,
        style = "minimal",
        border = "rounded",
        source = false,
        header = "",
        prefix = "",
    },
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = " ",
        [vim.diagnostic.severity.WARN] = " ",
        [vim.diagnostic.severity.INFO] = " ",
        [vim.diagnostic.severity.HINT] = "󰌵 ",
      }
    },
})

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.autoindent = true
vim.opt.autoread = true
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.undofile = true
vim.opt.showmode = false
vim.opt.fillchars = vim.opt.fillchars + 'diff:╱'

vim.opt.clipboard = "unnamedplus"
vim.opt_local.formatoptions:remove({ 'r', 'o' })

vim.wo.number = true
vim.wo.relativenumber = true

vim.o.foldcolumn = "1"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.g.netrw_banner = 0
-- vim.opt.foldmethod = "manual"
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

require('todo-comments').setup()

require("luasnip.loaders.from_vscode").load({ paths = { "./lua/snippets" } })

require('illuminate').configure({
    providers = {
        'lsp',
        'treesitter',
        'regex',
    },
    min_count_to_highlight = 1,
})


local harpoon = require('harpoon')
harpoon:setup()

vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Add item in harpoon" })
vim.keymap.set("n", "<leader>he", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Open harpoon window" })
vim.keymap.set("n", "<C-n>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-p>", function() harpoon:list():next() end)

