return {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    opts = {
        bind = true,
        handler_opts = { border = "rounded" },
        hint_enable = true,
        hint_prefix = "⚕️ ",
        floating_window = true,
        floating_window_above_cur_line = true,
        -- … other options you like
    },
}
