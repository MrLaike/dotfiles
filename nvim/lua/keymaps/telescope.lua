local telescope = require('telescope.builtin')
-- vim.keymap.set({ "n", "v" }, "<leader>sf", telescope.find_files)
-- vim.keymap.set({ "n", "v" }, "<leader>sw", telescope.live_grep)
vim.keymap.set('n', '<leader>sb', '<cmd>Telescope buffers<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>st', '<cmd>Telescope help_tags<CR>', { noremap = true, silent = true })

