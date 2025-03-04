vim.g.mapleader=' '
local keymap = require('utils.keymap')
keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
keymap("i", "<C-c>", "<Esc>", { noremap = true, silent = true })
keymap('n', '<C-w>q', '', { noremap = true, silent = true })
keymap('n', '<C-n>', '<C-6>', { noremap = true, silent = true })
keymap('n', '<C-c>', '<cmd>noh<CR>', { noremap = true, silent = true })

require('keymaps.dap')
require('keymaps.lspconfig')
require('keymaps.lang')
require('keymaps.hop')

-- Explorer
vim.keymap.set('n', '<leader>e', function() require('oil').open_float() end, { noremap = true, silent = true })

keymap('n', '<C-_>',  '<cmd>NERDCommenterToggle<CR>', { noremap = true, silent = true })

keymap('n', '<leader>ou', '<cmd>URLOpenUnderCursor<CR>', { noremap = true, silent = true, desc = "[o]pen [u]rl}" })

keymap('n', '<M-CR>', '<cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })

vim.keymap.set('v', '<C-j>', ':m \'>+1<CR>gv=gv')
vim.keymap.set('v', '<C-k>', ':m \'<-2<CR>gv=gv')

vim.keymap.set('i', '<C-c>', '<Esc>')
vim.keymap.set('n', '<leader>r', ':%s/\\<<C-r><C-w>\\>//gI<Left><Left><Left>')

-- UndoTree Plugin
vim.keymap.set('n', '<leader>u', '<cmd>UndotreeToggle<CR>', { desc = "[u]ndo tree toggle" })

