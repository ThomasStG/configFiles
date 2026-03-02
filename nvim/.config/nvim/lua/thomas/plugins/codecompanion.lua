return {
    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "nvim-telescope/telescope.nvim",

            -- MCP (added, but unused for now)
            {
                "mcphub/mcphub.nvim",
                opts = {}, -- no servers, no tools, no keymaps
            },
        },
        event = "VeryLazy",
        config = function()
            require("codecompanion").setup({
                interactions = {
                    chat = {
                        adapter = {
                            name = "ollama",
                            model = "deepseek-coder:1.3b",
                        },
                    },
                    cmd = {
                        adapter = {
                            name = "ollama",
                            model = "deepseek-r1:14b",
                        },
                    },
                    background = {
                        adapter = {
                            name = "ollama",
                            model = "llama3.2:latest",
                        },
                    },
                },

                adapters = {
                    http = {
                        ollama = function()
                            return require("codecompanion.adapters").extend("openai_compatible", {
                                env = {
                                    url = "http://localhost:11434",
                                },
                            })
                        end,
                    },
                },

                display = {
                    chat = {
                        window = {
                            position = "right",
                            width = 0.4,
                        },
                    },
                    action_palette = {
                        provider = "telescope",
                    },
                },
                opts = {
                    log_level = "DEBUG",
                },
            })
        end,
    },
}
