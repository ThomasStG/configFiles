return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
        "williamboman/mason.nvim",
        "jay-babu/mason-nvim-dap.nvim",
    },
    config = function()
        -- Load Required Modules
        local dap = require("dap")
        local dapui = require("dapui")

        -- Mason Setup
        require("mason").setup()
        require("mason-nvim-dap").setup({
            ensure_installed = { "codelldb", "python", "js-debug-adapter" }, -- Add required adapters
            automatic_setup = true, -- Automatically configure installed debuggers
        })

        -- UI Setup
        dapui.setup()
        require("nvim-dap-virtual-text").setup({
            enabled = true,
            commented = true,
        })

        -- Automatically open/close DAP UI
        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end

        --  Python Debugging
        dap.adapters.python = {
            type = "executable",
            command = "python",
            args = { "-m", "debugpy.adapter" },
        }
        dap.configurations.python = {
            {
                type = "python",
                request = "launch",
                name = "Launch file",
                program = "${file}",
                pythonPath = function()
                    return "python" -- Modify if using a virtual environment
                end,
            },
        }

        --  C/C++ Debugging with codelldb
        dap.adapters.codelldb = {
            type = "server",
            port = "${port}",
            executable = {
                command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
                args = { "--port", "${port}" },
            },
        }
        dap.configurations.cpp = {
            {
                name = "Launch",
                type = "codelldb",
                request = "launch",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
            },
        }
        dap.configurations.c = dap.configurations.cpp

        --  JavaScript/TypeScript Debugging (via `js-debug-adapter`)
        dap.adapters.node2 = {
            type = "executable",
            command = vim.fn.stdpath("data") .. "/mason/bin/js-debug-adapter",
        }
        dap.configurations.javascript = {
            {
                name = "Launch Node.js",
                type = "node2",
                request = "launch",
                program = "${file}",
                cwd = vim.fn.getcwd(),
                sourceMaps = true,
                protocol = "inspector",
            },
        }
        dap.configurations.typescript = dap.configurations.javascript

        --  Go Debugging (Delve)
        dap.adapters.delve = {
            type = "server",
            port = "38697",
            executable = {
                command = vim.fn.stdpath("data") .. "/mason/bin/dlv",
                args = { "dap", "-l", "127.0.0.1:38697" },
            },
        }
        dap.configurations.go = {
            {
                type = "delve",
                name = "Debug",
                request = "launch",
                program = "${file}",
            },
        }

        -- DAP Sign Definitions
        vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "Error", linehl = "", numhl = "" })
        vim.fn.sign_define("DapStopped", { text = "🛑", texthl = "Warning", linehl = "", numhl = "" })
    end,
}
