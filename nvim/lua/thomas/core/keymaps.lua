vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
keymap.set("n", "x", '"_x', { desc = "Delete char without yanking" })
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

keymap.set("n", "<leader>mf", ":lua require('harpoon.mark').add_file()")
keymap.set("n", "<leader>mm", ":lua require('harpoon.ui').toggle_quick_menu()")
keymap.set("n", "<leader>md", ":lua require('harpoon.ui').nav_next()")
keymap.set("n", "<leader>mu", ":lua require('harpoon.ui').nav_prev()")

keymap.set("n", "<leader>gg", "<cmd>Gen<CR>", { desc = "Run gen.nvim with built in model" })
keymap.set("n", "<leader>gc", "<cmd>Gen Chat<CR>", { desc = "Open Chat with gen.nvim" })
keymap.set("x", "<leader>gg", ":'<,'>Gen<CR>", { desc = "Open menu with highlighted selected as parameter" })

keymap.set("x", "gl", "<Plug>(lion-align)", { desc = "Align text with lion (left)" }) -- Align left
keymap.set("x", "gL", "<Plug>(lion-align-right)", { desc = "Align text with lion (right)" }) -- Align right
keymap.set("n", "<leader>a", ":Floaterminal", { desc = "Call the floating terminal from options.lua" })

keymap.set("n", "<leader>ee", ":CodeCompanion<CR>", { desc = "open codecompanion" })
keymap.set("n", "<leader>ec", ":CodeCompanionChat<CR>", { desc = "open codecompanion code" })
keymap.set("n", "<leader>ea", ":CodeCompanionActions<CR>", { desc = "open codecompanion actions" })
keymap.set("v", "<leader>ee", ":'<,'>CodeCompanion<CR>", { desc = "pass highlighted section to codecompanion" })

keymap.set("n", "<BS>", "^", { desc = "go to start of line" })
keymap.set("n", "<leader>.", ":TransparentToggle<cr>", { noremap = true, silent = true, desc = "Toggle Transparency" })
keymap.set("n", "<leader>of", function()
    local file = vim.fn.expand("%:p") -- Get full path of the current file
    vim.cmd("!code " .. file .. " &") -- Open in VS Code (runs in background)
end, { desc = "Open current file in VS Code" })
keymap.set("n", "<leader>oF", function()
    vim.cmd("!code . &") -- Open in VS Code (runs in background)
end, { desc = "Open current project in VS Code" })
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
