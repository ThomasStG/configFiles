return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2", -- Use the latest version
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    config = function()
        local harpoon = require("harpoon")
        local map = vim.keymap.set

        harpoon:setup({})
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

        map("n", "<leader>hM", function()
            toggle_telescope(harpoon:list())
        end, { desc = "Open harpoon menu" })

        map("n", "<leader>hm", function()
            harpoon:list():add()
        end)
        map("n", "<leader>hl", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end)

        map("n", "<leader>ha", function()
            harpoon:list():select(1)
        end)
        map("n", "<leader>hs", function()
            harpoon:list():select(2)
        end)
        map("n", "<leader>hd", function()
            harpoon:list():select(3)
        end)
        map("n", "<leader>hf", function()
            harpoon:list():select(4)
        end)
        -- Toggle previous & next buffers stored within Harpoon list
        map("n", "<leader>hp", function()
            harpoon:list():prev()
        end)
        map("n", "<leader>hn", function()
            harpoon:list():next()
        end)
    end,
}
