vim.g.mapleader = " "


vim.keymap.set("n", "<leader>-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("i", "<leader>jk", "<ESC>", { desc = "exit insert mode" })
vim.keymap.set("i", "<leader>kj", "<ESC>", { desc = "exit insert mode" })

vim.keymap.set("n", "<leader>w", "<CMD>w<CR>", {desc = "Quick save" })
vim.keymap.set("n", "<leader>x", "<CMD>wqa<CR>", {desc = "Sace and quit nvim" })
vim.keymap.set("n", "<leader>z", "<CMD>wq<CR>", {desc = "Sace and close current file" })

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fs', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
