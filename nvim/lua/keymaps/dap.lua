vim.keymap.set('n', '<leader>dp', '<cmd>DapToggleBreakpoint<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>dc', '<cmd>DapContinue<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>do', '<cmd>DapStepOver<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>di', '<cmd>DapStepInto<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>dt', '<cmd>DapStepOut<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Diagnostic open float " })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Diagnostic goto prev" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Diagnostic goto next" })
vim.keymap.set('n', '<leader>du', function() require("dapui").toggle() end, { desc = "Toggle diagnostic ui" })



