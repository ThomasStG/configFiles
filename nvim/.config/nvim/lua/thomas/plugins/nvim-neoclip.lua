return {
    "AckslD/nvim-neoclip.lua",
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "kkharji/sqlite.lua", -- Required for persistence
    },
    config = function()
        require("neoclip").setup({
            history = 1000,
            enable_persistent_history = true,
            continuous_sync = true,
            db_path = vim.fn.stdpath("data") .. "/databases/neoclip.sqlite3",
            filter = nil,
            preview = true,
            prompt = nil,
            enable_system_clipboard = true,
            default_register = { '"', "+", "*" },
            default_register_macros = "q",
            dedent_picker_display = true,
            initial_mode = "normal",
            enable_macro_history = true,
            content_spec_column = false,
            disable_keycodes_parsing = false,
            on_select = {
                move_to_front = false,
                close_telescope = true,
            },
            on_paste = {
                set_reg = false,
                move_to_front = false,
                close_telescope = true,
            },
            on_replay = {
                set_reg = false,
                move_to_front = false,
                close_telescope = true,
            },
            on_custom_action = {
                close_telescope = true,
            },
            keys = {
                telescope = {
                    i = {
                        select = "<cr>",
                        paste = "<c-p>",
                        paste_behind = "<c-k>",
                        replay = "<c-q>", -- replay a macro
                        delete = "<c-d>", -- delete an entry
                        edit = "<c-e>", -- edit an entry
                        custom = {},
                    },
                    n = {
                        select = "<cr>",
                        paste = "p",
                        --- It is possible to map to more than one key.
                        -- paste = { 'p', '<c-p>' },
                        paste_behind = "P",
                        replay = "q",
                        delete = "d",
                        edit = "e",
                        custom = {},
                    },
                },
                fzf = {
                    select = "default",
                    paste = "ctrl-p",
                    paste_behind = "ctrl-k",
                    custom = {},
                },
            },

            vim.api.nvim_create_autocmd("TextYankPost", {
                pattern = "*",
                callback = function()
                    local ok, neoclip = pcall(require, "neoclip")
                    if not ok or not neoclip.storage then
                        return
                    end

                    local clipboard_content = vim.fn.getreg("+") -- Read system clipboard
                    if clipboard_content ~= "" then
                        pcall(function()
                            neoclip.storage.add({
                                register = { "+", "*", '"' }, -- Track system & default registers
                                contents = { clipboard_content },
                                filetype = "plaintext",
                            })
                        end)
                    end
                end,
            }),
        })
        -- --Load Telescope extension
        require("telescope").load_extension("neoclip")
    end,
}
