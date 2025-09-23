-- config/keymaps.lua
local builtin = require('telescope.builtin')

-- Telescope
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Help tags' })

-- Neo-tree (garder <Space>e)
vim.keymap.set('n', '<leader>e', ':Neotree filesystem reveal left<CR>', { desc = 'Toggle Explorer' })

-- Diagnostics LSP (nouveau mapping)
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Show diagnostics' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Diagnostics list' })

-- Run/Debug keymaps
vim.keymap.set('n', '<leader>rr', '<cmd>RunCode<cr>', { desc = 'Run current file' })
vim.keymap.set('n', '<leader>rf', '<cmd>RunFile<cr>', { desc = 'Run file with input' })
vim.keymap.set('n', '<leader>rt', '<cmd>ToggleTerm<cr>', { desc = 'Toggle terminal' })
