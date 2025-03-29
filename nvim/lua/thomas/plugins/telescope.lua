return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "debugloop/telescope-undo.nvim",
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-tree/nvim-web-devicons",
        "folke/todo-comments.nvim",
        "folke/trouble.nvim", -- Ensure trouble.nvim is included in the dependencies
        "ThePrimeagen/harpoon",
        "mfussenegger/nvim-dap",
        "nvim-telescope/telescope-dap.nvim",
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local transform_mod = require("telescope.actions.mt").transform_mod
        local trouble = require("trouble")
        local trouble_telescope = require("trouble.sources.telescope")
        require("telescope").load_extension("dap")

        -- Custom action for quickfix list
        local custom_actions = transform_mod({
            open_trouble_qflist = function(prompt_bufnr)
                trouble.toggle("quickfix")
            end,
        })

        -- Setup for Telescope
        telescope.setup({
            defaults = {
                path_display = { "smart" },
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous, -- move to prev result
                        ["<C-j>"] = actions.move_selection_next, -- move to next result
                        ["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
                        ["<C-t>"] = trouble_telescope.open, -- Updated to use the new function
                    },
                },
            },
            extensions = {
                undo = {
                    side_by_side = true,
                    layout_strategy = "vertical",
                    layout_config = {
                        preview_height = 1,
                    },
                    on_select = function(entry)
                        vim.cmd("w") -- Save the file to trigger `BufWritePost`
                        vim.cmd("undo")
                    end,
                },
            },
        })

        -- Load extensions
        telescope.load_extension("undo")
        telescope.load_extension("fzf")
        telescope.load_extension("harpoon")

        -- Keymaps
        local keymap = vim.keymap -- for conciseness
        keymap.set("n", "<leader>t", "<cmd>Telescope undo<cr>", { desc = "Telescope undo history" })
        keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
        keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
        keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
        keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
        keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })

        vim.api.nvim_set_keymap(
            "n",
            "<leader>dc",
            "<cmd>Telescope dap configurations<CR>",
            { noremap = true, silent = true }
        )
    end,
}
