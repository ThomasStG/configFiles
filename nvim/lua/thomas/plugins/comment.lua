return {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
        -- import comment plugin safely
        local comment = require("Comment")
        local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

        -- enable comment
        comment.setup({
            -- for commenting tsx, jsx, svelte, html files
            padding = true, -- Adds a space between the comment marker and the text
            sticky = true, -- Keeps the cursor in its position after commenting
            ignore = "^$", -- lines to ignore when commenting
            toggler = {
                line = "gcc", -- keymap for toggling line comments
                block = "gbc", -- Keymap for toggling block comments
            },
            opleader = {
                line = "gc", -- Keymap for line comments in operator-pending mode
                block = "gb", -- Keymap for block comments in operator-pending mode
            },
            extra = {
                above = "gcO", -- Comment on the line above
                below = "gco", -- Comment on the line below
                eol = "gcA", -- Comment at the end of the line
            },
            mappings = {
                basic = true, -- Enables `gcc`, `gbc`, etc.
                extra = true, -- Enables `gcO`, `gco`, `gcA`
            },
            post_hook = nil, -- Hook to run after commenting
            pre_hook = ts_context_commentstring.create_pre_hook(),
        })
    end,
}
