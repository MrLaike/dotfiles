-- We need to ensure that we are in the directory specified when opening the file
local group_cdpwd = vim.api.nvim_create_augroup("group_cdpwd", { clear = true })


vim.api.nvim_create_autocmd({"VimEnter", "BufEnter" }, {
    group = group_cdpwd,
    pattern = {"*"},
    callback = function()
        vim.api.nvim_set_current_dir(vim.fn.expand("%:p:h"))
    end,
    once = true,
})

vim.cmd [[ 
hi DiagnosticUnderlineError guisp='Red' gui=undercurl
hi DiagnosticUnderlineWarn guisp='Yellow' gui=undercurl
hi DiagnosticUnderlineInfo guisp='Cyan' gui=undercurl
hi DiagnosticUnderlineHint guisp='Blue' gui=undercurl
set termguicolors
]]

require('plugins')
require('keymaps')

vim.diagnostic.config({
    underline = true,
    virtual_text = false,
    { virtual_lines = { only_current_line = true } },
    update_in_insert = false,
    float = {
        source = "always",
        border = "rounded",
    },
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = " ",
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

vim.opt.clipboard = "unnamedplus"
vim.opt_local.formatoptions:remove({ 'r', 'o' })

vim.wo.number = true
vim.wo.relativenumber = true

vim.o.foldcolumn = "1"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.o.winwidth = 10
vim.o.winminwidth = 10
vim.o.equalalways = false

vim.g.netrw_banner = 0

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

