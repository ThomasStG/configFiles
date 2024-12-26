return {
    "ggandor/leap.nvim",
    config = function()
        require("leap").add_default_mappings()
        -- Optional configuration for leap
        require("leap").setup({
            max_aop = 1, -- Maximum number of target matches to highlight
            case_sensitive = false, -- Enable/disable case sensitivity
        })
        vim.keymap.set("n", "fc", "<Plug>(leap)")
        vim.keymap.set("n", " fv", "<Plug>(leap-from-window)")
        vim.keymap.set({ "x", "o" }, "fc", "<Plug>(leap-forward)")
        vim.keymap.set({ "x", "o" }, "fv", "<Plug>(leap-backward)")
        -- Define equivalence classes for brackets and quotes, in addition to
        -- the default whitespace group.
        require("leap").opts.equivalence_classes = { " \t\r\n", "([{", ")]}", "'\"`" }

        -- Use the traversal keys to repeat the previous motion without explicitly
        -- invoking Leap.
        require("leap.user").set_repeat_keys("<enter>", "<backspace>")
    end,
}
