return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2", -- Use the latest version
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    config = function()
        local harpoon = require("harpoon")

        harpoon:setup({
            settings = {
                save_on_toggle = true, -- Save marks when toggling UI
                sync_on_ui_close = true, -- Sync marks when closing UI
                mark_branch = true, -- Separate marks per Git branch
                tabline = false, -- Disable tabline UI (optional)
            },
        })
        local conf = require("telescope.config").values
        local function toggle_telescope(harpoon_files)
            local file_paths = {}
            for _, item in ipairs(harpoon_files.items) do
                table.insert(file_paths, item.value)
            end

            require("telescope.pickers")
                .new({}, {
                    prompt_title = "Harpoon",
                    finder = require("telescope.finders").new_table({
                        results = file_paths,
                    }),
                    previewer = conf.file_previewer({}),
                    sorter = conf.generic_sorter({}),
                })
                :find()
        end
        -- Keybindings
        local keymap = vim.keymap.set
        local mark = harpoon:list()

        keymap("n", "<leader>hm", function()
            harpoon:list():add()
        end, { desc = "Add file to Harpoon" })
        keymap("n", "<leader>hl", function()
            harpoon.ui:toggle_quick_menu(mark)
        end, { desc = "Toggle Harpoon menu" })

        -- Jump to specific marks
        keymap("n", "<leader>ha", function()
            harpoon:list():select(1)
        end, { desc = "Jump to Harpoon file 1" })
        keymap("n", "<leader>hs", function()
            harpoon:list():select(2)
        end, { desc = "Jump to Harpoon file 2" })
        keymap("n", "<leader>hd", function()
            harpoon:list():select(3)
        end, { desc = "Jump to Harpoon file 3" })
        keymap("n", "<leader>hf", function()
            harpoon:list():select(4)
        end, { desc = "Jump to Harpoon file 4" })

        keymap("n", "<leader>ht", function()
            toggle_telescope(mark)
        end, { desc = "Toggle Harpoon menu" })

        -- Navigate between marked files
        keymap("n", "<leader>hn", function()
            harpoon:list():next()
        end, { desc = "Next Harpoon file" })
        keymap("n", "<leader>hp", function()
            harpoon:list():prev()
        end, { desc = "Previous Harpoon file" })
    end,
}
