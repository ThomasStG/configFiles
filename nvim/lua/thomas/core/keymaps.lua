vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness
pcall(vim.keymap.del, "n", "<c-y>")

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

keymap.set("n", "<leader>w", ":w<CR>", { desc = "save" })
keymap.set("n", "<leader>q", ":q<CR>", { desc = "quit" })
keymap.set("n", "<leader>x", ":wqa<CR>", { desc = "save or quit all" })
keymap.set("n", "<leader>z", ":wq<CR>", { desc = "save or close  current file" })

keymap.set("n", "<leader>y", '"*y', { desc = "copy " })
keymap.set("n", "Y", "y$", { desc = "copy to end of line" })

keymap.set("", "<up>", "<nop>", { noremap = true })
keymap.set("", "<down>", "<nop>", { noremap = true })
keymap.set("i", "<up>", "<nop>", { noremap = true })
keymap.set("i", "<down>", "<nop>", { noremap = true })

keymap.set("", "<left>", "<nop>", { noremap = false })
keymap.set("", "<right>", "<nop>", { noremap = false })
keymap.set("i", "<left>", "<nop>", { noremap = true })
keymap.set("i", "<right>", "<nop>", { noremap = true })

keymap.set("i", "<leader>jk", "<ESC>", { desc = "exit insert mode" })
keymap.set("i", "<leader>kj", "<ESC>", { desc = "exit insert mode" })
keymap.set("v", "<leader>jk", "<ESC>", { desc = "exit visual mode" })
keymap.set("v", "<leader>kj", "<ESC>", { desc = "exit visual mode" })

keymap.set("n", "<leader>[", function()
    require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true })

keymap.set("n", "<leader>fd", function()
    require("telescope").extensions.neoclip.default()
end, { silent = true, noremap = true, desc = "Open Neoclip with Telescope" })

keymap.set("n", "[c", function()
    require("treesitter-context").go_to_context(vim.v.count0)
end, { silent = true })

keymap.set("n", "]c", function()
    require("treesitter-context").go_to_context(vim.v.count0)
end, { silent = true })

-- keymap.set("n", "<leader>u", ":m .-2<CR>==", { desc = "Move line up" })
-- keymap.set("v", "<leader>u", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
-- keymap.set("v", "<leader>U", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
-- keymap.set("n", "<leader>U", ":m .+1<CR>==", { desc = "Move line down" })

keymap.set("v", "<", "<gv", { desc = "Indent left or reselect" })
keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

keymap.set("n", "<leader>mf", ":lua require('harpoon.mark').add_file()")
keymap.set("n", "<leader>mm", ":lua require('harpoon.ui').toggle_quick_menu()")
keymap.set("n", "<leader>md", ":lua require('harpoon.ui').nav_next()")
keymap.set("n", "<leader>mu", ":lua require('harpoon.ui').nav_prev()")

keymap.set("n", "<leader>gg", "<cmd>Gen<CR>", { desc = "Run gen.nvim with built in model" })
keymap.set("n", "<leader>gc", "<cmd>Gen Chat<CR>", { desc = "Open Chat with gen.nvim" })
keymap.set("x", "<leader>gg", ":'<,'>Gen<CR>", { desc = "Open menu with highlighted selected as parameter" })

keymap.set("x", "gl", "<Plug>(lion-align)", { desc = "Align text with lion (left)" }) -- Align left
keymap.set("x", "gL", "<Plug>(lion-align-right)", { desc = "Align text with lion (right)" }) -- Align right

keymap.set("n", "<leader>ot", ":Floaterminal<CR>", { desc = "Call the floating terminal from options.lua" })

keymap.set("n", "<leader>ci", function()
    vim.cmd("Codeium Toggle")
end, { desc = "Toggle Codeium" })

keymap.set("n", "<BS>", "^", { desc = "go to start of line" })
keymap.set("n", "<leader>.", ":TransparentToggle<cr>", { noremap = true, silent = true, desc = "Toggle Transparency" })
keymap.set("n", "<leader>of", function()
    local file = vim.fn.expand("%:p") -- Get full path of the current file
    vim.cmd("!code " .. file .. " &") -- Open in VS Code (runs in background)
end, { desc = "Open current file in VS Code" })
keymap.set("n", "<leader>oF", function()
    vim.cmd("!code . &") -- Open in VS Code (runs in background)
end, { desc = "Open current project in VS Code" })
vim.keymap.set("n", "<leader>fd", function()
    local ok, telescope = pcall(require, "telescope")
    if not ok then
        print("Telescope not found")
        return
    end

    local ok_neoclip, _ = pcall(require, "neoclip")
    if not ok_neoclip then
        print("Neoclip not found")
        return
    end
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    require("telescope").extensions.neoclip.default({
        attach_mappings = function(_, map)
            map("i", "<d-c>", function(prompt_bufnr)
                local entry = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                if entry then
                    -- Store selected entry into the default register and the system clipboard
                    vim.fn.setreg('"', entry.value) -- Overwrite unnamed register
                    vim.fn.setreg("+", entry.value) -- Overwrite system clipboard

                    -- Paste it immediately
                    vim.api.nvim_put({ entry.value }, "c", true, true)
                end
            end)
            return true
        end,
    })
end, { desc = "Replace clipboard with selected item from neoclip and paste it" })

vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        local ft = vim.bo.filetype
        if ft == "c" then
            vim.bo.makeprg = "gcc % -o %<"
        elseif ft == "cpp" then
            vim.bo.makeprg = "g++ % -o %<"
        elseif ft == "python" then
            vim.bo.makeprg = "python3 %"
        elseif ft == "lua" then
            vim.bo.makeprg = "luac -p %"
        else
            vim.bo.makeprg = ""
        end
    end,
})

local function run_in_tmux()
    local ft = vim.bo.filetype
    local cmd

    if ft == "c" or ft == "cpp" then
        cmd = "./" .. vim.fn.expand("%:r")
    elseif ft == "python" then
        cmd = "python3 " .. vim.fn.expand("%")
    elseif ft == "lua" then
        cmd = "lua " .. vim.fn.expand("%")
    else
        print("No run command for filetype: " .. ft)
        return
    end

    vim.fn.system("tmux split-window -v '" .. cmd .. " ; exec $SHELL'")
end

vim.keymap.set("n", "<leader><C-r>", run_in_tmux, { desc = "Run program in tmux split" })
vim.keymap.set({ "n", "x" }, "<leader>re", function()
    return require("refactoring").refactor("Extract Function")
end, { expr = true, desc = "Extract Function" })
vim.keymap.set({ "n", "x" }, "<leader>rf", function()
    return require("refactoring").refactor("Extract Function To File")
end, { expr = true, desc = "Extract Function To File" })
vim.keymap.set({ "n", "x" }, "<leader>rv", function()
    return require("refactoring").refactor("Extract Variable")
end, { expr = true, desc = "Extract Variable" })
vim.keymap.set({ "n", "x" }, "<leader>rI", function()
    return require("refactoring").refactor("Inline Function")
end, { expr = true, desc = "Inline Function" })
vim.keymap.set({ "n", "x" }, "<leader>ri", function()
    return require("refactoring").refactor("Inline Variable")
end, { expr = true, desc = "Inline Variable" })

vim.keymap.set({ "n", "x" }, "<leader>rbb", function()
    return require("refactoring").refactor("Extract Block")
end, { expr = true, desc = "Extract Block" })
vim.keymap.set({ "n", "x" }, "<leader>rbf", function()
    return require("refactoring").refactor("Extract Block To File")
end, { expr = true, desc = "Extract Block To File" })
