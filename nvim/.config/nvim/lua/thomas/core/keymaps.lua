vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local map = vim.keymap.set
pcall(vim.keymap.del, "n", "<c-y>")

map("n", "<leader>w", ":w<CR>", { desc = "save" })
map("n", "<leader>q", ":q<CR>", { desc = "quit" })
map("n", "<leader>x", ":wqa<CR>", { desc = "save or quit all" })
map("n", "<leader>z", ":wq<CR>", { desc = "save or close  current file" })

map("n", "<leader>y", '"*y', { desc = "copy " })
map("n", "Y", "y$", { desc = "copy to end of line" })

map("i", "<leader>jk", "<ESC>", { desc = "exit insert mode" })
map("i", "<leader>kj", "<ESC>", { desc = "exit insert mode" })
map("v", "<leader>jk", "<ESC>", { desc = "exit visual mode" })
map("v", "<leader>kj", "<ESC>", { desc = "exit visual mode" })

map("n", "<leader>[", function()
    require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true })

map("v", "<", "<gv", { desc = "Indent left or reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })

map("n", "<leader>ci", function()
    vim.cmd("Codeium Toggle")
end, { desc = "Toggle Codeium" })

map("n", "<BS>", "^", { desc = "go to start of line" })
map("n", "<leader>.", ":TransparentToggle<cr>", { noremap = true, silent = true, desc = "Toggle Transparency" })
map("n", "<leader>of", function()
    local file = vim.fn.expand("%:p") -- Get full path of the current file
    vim.cmd("!code " .. file .. " &") -- Open in VS Code (runs in background)
end, { desc = "Open current file in VS Code" })
map("n", "<leader>oF", function()
    vim.cmd("!code . &") -- Open in VS Code (runs in background)
end, { desc = "Open current project in VS Code" })


map({ "n", "v" }, "<leader>mp", function()
    require("conform").format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
    })
end, { desc = "Format file or range (in visual mode)" })
