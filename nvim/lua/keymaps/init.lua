vim.g.mapleader=' '
local keymap = require('utils.keymap')
keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
keymap("i", "<C-c>", "<Esc>", { noremap = true, silent = true })

require('keymaps.telescope')
require('keymaps.dap')
require('keymaps.lspconfig')
require('keymaps.lang')
require('keymaps.hop')

-- Explorer
keymap('n', '<leader>e', '<cmd>Neotree toggle<CR>', { noremap = true, silent = true })
keymap('n', '<C-w>q', '', { noremap = true, silent = true })

keymap('n', '<C-_>',  '<cmd>NERDCommenterToggle<CR>', { noremap = true, silent = true })


keymap('n', '<leader>ou', '<esc>:URLOpenUnderCursor<cr>', { noremap = true, silent = true })

keymap('n', '<C-i>', '<C-6>', { noremap = true, silent = true })
keymap('n', '<C-c>', '<cmd>noh<CR>', { noremap = true, silent = true })

keymap('n', '<M-CR>', '<cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })

vim.keymap.set('v', '<C-j>', ':m \'>+1<CR>gv=gv')
vim.keymap.set('v', '<C-k>', ':m \'<-2<CR>gv=gv')

vim.keymap.set('i', '<C-c>', '<Esc>')
vim.keymap.set('n', '<leader>r', ':%s/\\<<C-r><C-w>\\>//gI<Left><Left><Left>')

-- Luasnip Plugin
local ls = require('luasnip')

vim.keymap.set({'i'}, '<C-K>', function() ls.expand() end, {silent = true})
vim.keymap.set({'i', 's'}, '<C-L>', function() ls.jump( 1) end, {silent = true})
vim.keymap.set({'i', 's'}, '<C-J>', function() ls.jump(-1) end, {silent = true})

vim.keymap.set({'i', 's'}, '<C-E>', function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, {silent = true})


-- UndoTree Plugin
vim.keymap.set('n', '<leader>u', '<cmd>UndotreeToggle<CR>')
