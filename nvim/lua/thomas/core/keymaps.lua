vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new ta

-- keymap.set("n", "<C-h>", "<cmd>wincmd h<CR>", { noremap = true, silent = true, desc = "Pane left" })
-- keymap.set("n", "<C-j>", "<cmd>wincmd j<CR>", { noremap = true, silent = true, desc = "Pane down" })
-- keymap.set("n", "<C-k>", "<cmd>wincmd k<CR>", { noremap = true, silent = true, desc = "Pane up" })
-- keymap.set("n", "<C-l>", "<cmd>wincmd l<CR>", { noremap = true, silent = true, desc = "Pane right" })

keymap.set("n", "<leader>w", ":w<CR>", { desc = "save" })
keymap.set("n", "<leader>q", ":q<CR>", { desc = "quit" })
keymap.set("n", "<leader>x", ":wqa<CR>", { desc = "save and quit all" })
keymap.set("n", "<leader>z", ":wq<CR>", { desc = "save and close  current file" })

keymap.set("n", "<leader>y", '"*y', { desc = "copy " })

keymap.set("n", "<leader>t", ":GundoToggle<CR>", { desc = "undo Tree" })
keymap.set("", "<up>", "<nop>", { noremap = true })
keymap.set("", "<down>", "<nop>", { noremap = true })
keymap.set("i", "<up>", "<nop>", { noremap = true })
keymap.set("i", "<down>", "<nop>", { noremap = true })

keymap.set("i", "<leader>jk", "<ESC>", { desc = "exit insert mode" })
keymap.set("i", "<leader>kj", "<ESC>", { desc = "exit insert mode" })
keymap.set("i", "<leader> ", " ", { desc = "two spaces = 1 space" })

keymap.set("n", "<leader>[", function()
    require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true })

keymap.set("n", "<leader>fd", function()
    require("telescope").extensions.neoclip.default()
end, { silent = true, noremap = true, desc = "Open Neoclip with Telescope" })

keymap.set("n", "[c", function()
    require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true })

keymap.set("x", "gl", "<Plug>(lion-align)", { desc = "Align text with lion (left)" }) -- Align left
keymap.set("x", "gL", "<Plug>(lion-align-right)", { desc = "Align text with lion (right)" }) -- Align right
keymap.set("n", "<leader>a", ":Floaterminal", { desc = "Call the floating terminal from options.lua" })

-- vim.keymap.set("n", "<leader>fd", function()
--     local actions = require("telescope.actions") -- import actions
--     local action_state = require("telescope.actions.state") -- import action_state
--     require("telescope").extensions.neoclip.default({
--         attach_mappings = function(_, map)
--             map("i", "<d-c>", function(prompt_bufnr)
--                 local entry = action_state.get_selected_entry()
--                 actions.close(prompt_bufnr)
--                 if entry then

--                     -- Execute commands: `p` to paste, `V` to select the line, and `d` to delete
--                     vim.api.nvim_feedkeys("pVd", "n", false)
--                 end
--             end)
--             return true
--         end,
--     })
-- end, { desc = "replace clipboard with selected item from neoclip and perform actions" })
--
-- print
