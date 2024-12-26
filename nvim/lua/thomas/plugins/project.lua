return {
    "ahmedkhalf/project.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" }, -- Optional, for Telescope integration
    config = function()
        require("project_nvim").setup({
            -- Set the patterns to detect project root
            detection_methods = { "lsp", "pattern" }, -- Use both LSP and patterns
            patterns = { ".git", "Makefile", "package.json" }, -- Customize as needed

            -- Exclude directories from being treated as projects
            exclude_dirs = { "/tmp/*", "/private/tmp/*" },

            -- Automatically change the working directory
            sync_root_with_cwd = true,
            respect_buf_cwd = true, -- Use the current buffer's directory as root if possible

            -- Additional options
            show_hidden = true, -- Include hidden files when detecting projects
            datapath = vim.fn.stdpath("data"), -- Store project data in standard path
        })

        -- Telescope integration for Project.nvim
        require("telescope").load_extension("projects")

        -- Optional integration with nvim-tree
        require("nvim-tree").setup({
            sync_root_with_cwd = true,
            respect_buf_cwd = true,
            update_focused_file = {
                enable = true,
                update_root = true,
            },
        })

        -- Keymap for opening projects with Telescope
        vim.keymap.set("n", "<leader>pr", "<cmd>Telescope projects<CR>", { desc = "Open projects" })
    end,
}

