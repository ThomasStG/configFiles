return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "MeanderingProgrammer/render-markdown.nvim",
    },
    opts = {
        strategies = {
            chat = {
                adapter = "ollama",
            },
            inline = {
                adapter = "ollama",
                keymaps = {
                    accept_change = {
                        modes = { n = "<leader>a" },
                        description = "Accept the suggested change",
                    },
                    reject_change = {
                        modes = { n = "<leader>r" },
                        description = "Reject the suggested change",
                    },
                },
            },
        },
        adapters = {
            codellama = function()
                return require("codecompanion.adapters").extend("ollama", {
                    name = "codellama", -- Give this adapter a different name to differentiate it from the default ollama adapter
                    schema = {
                        model = {
                            default = "codellama:13b",
                        },
                        num_ctx = {
                            default = 16384,
                        },
                        num_predict = {
                            default = -1,
                        },
                    },
                })
            end,
            phind_codellama = function()
                return require("codecompanion.adapters").extend("ollama", {
                    name = "phind-codellama", -- Give this adapter a different name to differentiate it from the default ollama adapter
                    schema = {
                        model = {
                            default = "phind-codellama:latest",
                        },
                        num_ctx = {
                            default = 16384,
                        },
                        num_predict = {
                            default = -1,
                        },
                    },
                })
            end,
            deepseek_coder = function()
                return require("codecompanion.adapters").extend("ollama", {
                    name = "deepseek-coder", -- Give this adapter a different name to differentiate it from the default ollama adapter
                    schema = {
                        model = {
                            default = "deepseek-coder:latest",
                        },
                        num_ctx = {
                            default = 16384,
                        },
                        num_predict = {
                            default = -1,
                        },
                    },
                })
            end,
            starcoder = function()
                return require("codecompanion.adapters").extend("ollama", {
                    name = "starcoder", -- Give this adapter a different name to differentiate it from the default ollama adapter
                    schema = {
                        model = {
                            default = "starcoder:latest",
                        },
                        num_ctx = {
                            default = 16384,
                        },
                        num_predict = {
                            default = -1,
                        },
                    },
                })
            end,

            codegemma = function()
                return require("codecompanion.adapters").extend("ollama", {
                    name = "codegemma", -- Give this adapter a different name to differentiate it from the default ollama adapter
                    schema = {
                        model = {
                            default = "codegemma:latest",
                        },
                        num_ctx = {
                            default = 16384,
                        },
                        num_predict = {
                            default = -1,
                        },
                    },
                })
            end,
        },
        sources = {
            -- Enable the custom codellama adapter
            per_filetype = {
                lua = { "codellama" },
                python = { "codellama" },
                cpp = { "codegemma" }, -- C++
                cs = { "phind_codellama" }, -- C#
                ruby = { "starcoder" }, -- Ruby
                php = { "phind_codellama" }, -- PHP
                swift = { "phind_codellama" }, -- Swift
                kotlin = { "phind_codellama" }, -- Kotlin
                go = { "phind_codellama" }, -- Go
                rust = { "phind_codellama" }, -- Rust
                javascript = { "deepseek_coder" }, -- JavaScript
                typescript = { "phind_codellama" }, -- TypeScript
                html = { "codegemma" }, -- HTML
                css = { "codegemma" }, -- CSS
            },
        },
        opts = {
            -- Set debug logging
            log_level = "DEBUG",
        },

        display = {
            action_palette = {
                width = 95,
                height = 10,
                prompt = "Prompt ", -- Prompt used for interactive LLM calls
                provider = "telescope", -- default|telescope|mini_pick
                opts = {
                    show_default_actions = true, -- Show the default actions in the action palette?
                    show_default_prompt_library = true, -- Show the default prompt library in the action palette?
                },
            },
        },
    },
}
