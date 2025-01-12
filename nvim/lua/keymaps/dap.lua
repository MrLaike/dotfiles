local keymap = require('utils.keymap')

keymap('n', '<leader>dp', '<cmd>DapToggleBreakpoint<CR>', { noremap = true, silent = true })
keymap('n', '<leader>dc', '<cmd>DapContinue<CR>', { noremap = true, silent = true })
keymap('n', '<leader>do', '<cmd>DapStepOver<CR>', { noremap = true, silent = true })
keymap('n', '<leader>di', '<cmd>DapStepInto<CR>', { noremap = true, silent = true })
keymap('n', '<leader>dt', '<cmd>DapStepOut<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)


