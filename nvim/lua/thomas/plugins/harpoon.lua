return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2", -- Use the latest version
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")

        harpoon.setup({
            global_settings = {
                save_on_toggle = true, -- Automatically save marks
                sync_on_ui_close = true, -- Sync marks when closing UI
                mark_branch = true, -- Separate marks per Git branch
            },
        })

        -- Keybindings
        local keymap = vim.keymap.set
        local ui = require("harpoon.ui")
        local mark = require("harpoon.mark")

        keymap("n", "<leader>hm", function()
            mark.add_file()
        end, { desc = "Add file to Harpoon" })
        keymap("n", "<C-e>", function()
            ui.toggle_quick_menu()
        end, { desc = "Toggle Harpoon menu" })

        -- Jump to specific marks
        keymap("n", "<leader>ha", function()
            ui.nav_file(1)
        end, { desc = "Jump to Harpoon file 1" })
        keymap("n", "<leader>hs", function()
            ui.nav_file(2)
        end, { desc = "Jump to Harpoon file 2" })
        keymap("n", "<leader>hd", function()
            ui.nav_file(3)
        end, { desc = "Jump to Harpoon file 3" })
        keymap("n", "<leader>hf", function()
            ui.nav_file(4)
        end, { desc = "Jump to Harpoon file 4" })

        -- Navigate between marked files
        keymap("n", "<leader>hn", function()
            ui.nav_next()
        end, { desc = "Next Harpoon file" })
        keymap("n", "<leader>hp", function()
            ui.nav_prev()
        end, { desc = "Previous Harpoon file" })
    end,
}
