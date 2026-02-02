vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local keymap = vim.keymap -- for conciseness
local map = vim.keymap.set
pcall(keymap.del, "n", "<c-y>")

map("n", "<leader>ho", ":nohl<CR>", { desc = "Clear search highlights" })

map("n", "x", '"_x', { desc = "Delete char without yanking" })

-- window management
map("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
map("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
map("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

map("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
map("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
map("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
map("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
map("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new ta

map("n", "<leader>w", ":w<CR>", { desc = "save" })
map("n", "<leader>q", ":q<CR>", { desc = "quit" })
map("n", "<leader>x", ":wqa<CR>", { desc = "save or quit all" })
map("n", "<leader>z", ":wq<CR>", { desc = "save or close  current file" })

map("n", "<leader>y", '"*y', { desc = "copy " })
map("n", "Y", "y$", { desc = "copy to end of line" })

map("", "<up>", "<nop>", { noremap = true })
map("", "<down>", "<nop>", { noremap = true })
map("i", "<up>", "<nop>", { noremap = true })
map("i", "<down>", "<nop>", { noremap = true })

map("", "<left>", "<nop>", { noremap = false })
map("", "<right>", "<nop>", { noremap = false })
map("i", "<left>", "<nop>", { noremap = true })
map("i", "<right>", "<nop>", { noremap = true })

map("i", "<leader>jk", "<ESC>", { desc = "exit insert mode" })
map("i", "<leader>kj", "<ESC>", { desc = "exit insert mode" })
map("v", "<leader>jk", "<ESC>", { desc = "exit visual mode" })
map("v", "<leader>kj", "<ESC>", { desc = "exit visual mode" })

map("n", "<leader>[", function()
    require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true })

map("n", "<leader>fd", function()
    require("telescope").extensions.neoclip.default()
end, { silent = true, noremap = true, desc = "Open Neoclip with Telescope" })

map("n", "[c", function()
    require("treesitter-context").go_to_context(vim.v.count0)
end, { silent = true })

map("n", "]c", function()
    require("treesitter-context").go_to_context(vim.v.count0)
end, { silent = true })

-- map("n", "<leader>u", ":m .-2<CR>==", { desc = "Move line up" })
-- map("v", "<leader>u", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
-- map("v", "<leader>U", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
-- map("n", "<leader>U", ":m .+1<CR>==", { desc = "Move line down" })

map("v", "<", "<gv", { desc = "Indent left or reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })

map("n", "<leader>mf", ":lua require('harpoon.mark').add_file()")
map("n", "<leader>mm", ":lua require('harpoon.ui').toggle_quick_menu()")
map("n", "<leader>md", ":lua require('harpoon.ui').nav_next()")
map("n", "<leader>mu", ":lua require('harpoon.ui').nav_prev()")

map("n", "<leader>gg", "<cmd>Gen<CR>", { desc = "Run gen.nvim with built in model" })
map("n", "<leader>gc", "<cmd>Gen Chat<CR>", { desc = "Open Chat with gen.nvim" })
map("x", "<leader>gg", ":'<,'>Gen<CR>", { desc = "Open menu with highlighted selected as parameter" })

map("x", "gl", "<Plug>(lion-align)", { desc = "Align text with lion (left)" }) -- Align left
map("x", "gL", "<Plug>(lion-align-right)", { desc = "Align text with lion (right)" }) -- Align right

map("n", "<leader>ot", ":Floaterminal<CR>", { desc = "Call the floating terminal from options.lua" })

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
map("n", "<leader>is", ":IronRepl<CR>", { desc = "Open Iron REPL" })
map("n", "<leader>fd", function()
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

map("n", "<leader><C-r>", run_in_tmux, { desc = "Run program in tmux split" })
map({ "n", "x" }, "<leader>re", function()
    return require("refactoring").refactor("Extract Function")
end, { expr = true, desc = "Extract Function" })
map({ "n", "x" }, "<leader>rf", function()
    return require("refactoring").refactor("Extract Function To File")
end, { expr = true, desc = "Extract Function To File" })
map({ "n", "x" }, "<leader>rv", function()
    return require("refactoring").refactor("Extract Variable")
end, { expr = true, desc = "Extract Variable" })
map({ "n", "x" }, "<leader>rI", function()
    return require("refactoring").refactor("Inline Function")
end, { expr = true, desc = "Inline Function" })
map({ "n", "x" }, "<leader>ri", function()
    return require("refactoring").refactor("Inline Variable")
end, { expr = true, desc = "Inline Variable" })

map({ "n", "x" }, "<leader>rbb", function()
    return require("refactoring").refactor("Extract Block")
end, { expr = true, desc = "Extract Block" })
map({ "n", "x" }, "<leader>rbf", function()
    return require("refactoring").refactor("Extract Block To File")
end, { expr = true, desc = "Extract Block To File" })

-- Auto Session
map("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" }) -- restore last workspace session for current directory
map("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" }) -- save workspace session for current working directory

-- Code Companion
map("n", "<leader>aa", "<cmd>CodeCompanionChat Toggle<CR>", { desc = "AI Chat: Toggle" })
map("n", "<leader>ax", "<cmd>CodeCompanionChat Close<CR>", { desc = "AI Chat: Close" })

map("v", "<leader>ga", "<cmd>CodeCompanionChat Add<CR>", { desc = "AI Chat: Add selection" })
map("n", "<leader>am", function()
    require("codecompanion.actions").select_model()
end, { desc = "AI: Select model" })
map({ "n", "v" }, "<leader>ap", "<cmd>CodeCompanionActions<CR>", { desc = "AI Actions" })

-- Dial

-- Edgy

map({ "n" }, "<leader>el", "<cmd>Edgy toggle left<cr>", { desc = "Toggle Explorer sidebar" })
map({ "n" }, "<leader>tb", "<cmd>Edgy toggle bottom<cr>", { desc = "Toggle Terminal sidebar" })

-- Formatting

map({ "n", "v" }, "<leader>mp", function()
    require("conform").format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
    })
end, { desc = "Format file or range (in visual mode)" })

-- Harpoon

-- Iron

-- Lua Snip

-- vim dap

map("n", "<leader>db", function()
    dap.toggle_breakpoint()
end, { desc = "Toggle Breakpoint" })

map("n", "<leader>dc", function()
    dap.continue()
end, { desc = "Start/Continue Debugging" })

map("n", "<leader>do", function()
    dap.step_over()
end, { desc = "Step Over" })

map("n", "<leader>di", function()
    dap.step_into()
end, { desc = "Step Into" })

map("n", "<leader>du", function()
    dap.step_out()
end, { desc = "Step Out" })

map("n", "<leader>dx", function()
    dap.terminate()
end, { desc = "Terminate Debugging" })
