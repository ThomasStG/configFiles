return {
    "Vigemus/iron.nvim",
    config = function()
        local iron = require("iron.core")
        local map = vim.keymap.set

        iron.setup({
            config = {
                scratch_repl = true,

                repl_definition = {
                    markdown = {
                        command = { "R", "--quiet", "--no-save" },
                        startup = function()
                            return "setwd('" .. vim.fn.expand("%:p:h") .. "')"
                        end,
                    },
                    quarto = {
                        command = { "R", "--quiet", "--no-save" },
                        startup = function()
                            return "setwd('" .. vim.fn.expand("%:p:h") .. "')"
                        end,
                    },
                    r = {
                        command = { "R", "--quiet", "--no-save" },
                        startup = function()
                            return "setwd('" .. vim.fn.expand("%:p:h") .. "')"
                        end,
                    },
                    python = {
                        command = { "python" },
                        cwd = function()
                            return "cat('IRON STARTUP RAN\\n')"
                            -- return vim.fn.expand("%:p:h")
                        end,
                    },
                    julia = {
                        command = { "julia" },
                        cwd = function()
                            return vim.fn.expand("%:p:h")
                        end,
                    },
                    bash = {
                        command = { "bash" },
                        cwd = function()
                            return vim.fn.expand("%:p:h")
                        end,
                    },
                },

                repl_open_cmd = "botright split",
            },

            keymaps = {
                send_motion = "<localleader>sc",
                visual_send = "<localleader>sv",
                send_line = "<localleader>sl",
                send_file = "<localleader>sf",
                cr = "<localleader>s<cr>",
                interrupt = "<localleader>s<esc>",
                exit = "<localleader>sq",
                clear = "<localleader>cl",
            },

            highlight = {
                italic = true,
            },

            ignore_blank_lines = true,
        })
        local iron = require("iron.core")
        map("n", "<localleader>p", function()
            iron.send(nil, "ls()\n")
        end, { desc = "R: list global env" })

        -- Linting
        map("n", "<leader>l", function()
            require("lint").try_lint()
        end, { desc = "Trigger linting for current file" })
    end,
}
