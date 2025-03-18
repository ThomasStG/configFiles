return {
    "ggandor/leap.nvim",
    config = function()
        -- Optional configuration for leap
        require("leap").setup({
            case_sensitive = false, -- Enable/disable case sensitivity
        })
        vim.keymap.set("n", "<leader>le", "<Plug>(leap)")
        vim.keymap.set("n", "<leader>lw", "<Plug>(leap-from-window)")
        vim.keymap.set({ "x", "o" }, "<leader>L", "<Plug>(leap-backward)")
        -- Define equivalence classes for brackets and quotes, in addition to
        -- the default whitespace group.
        require("leap").opts.equivalence_classes = { " \t\r\n", "([{", ")]}", "'\"`" }

        -- Use the traversal keys to repeat the previous motion without explicitly invoking Leap.
        require("leap").add_default_mappings()
    end,
}
