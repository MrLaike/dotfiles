local hop = require('hop')
local directions = require('hop.hint').HintDirection

vim.keymap.set('', 'S', function() hop.hint_patterns({}) end, {remap=true, desc = "[S]earch current view area"})
vim.keymap.set('', 'f', function() hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true }) end, { remap = true, desc = "Find next char" })
vim.keymap.set('', 'F', function() hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true }) end, {remap = true, desc = "Find prev char" })
vim.keymap.set('', 't', function() hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 }) end, { remap = true, desc = "Find by next char" })
vim.keymap.set('', 'T', function() hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 }) end, { remap = true, desc = "Find by prev char" })


