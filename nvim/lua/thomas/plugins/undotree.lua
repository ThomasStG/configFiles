return {
    "mbbill/undotree",
    config = function()
        -- Persistent undo settings
        if vim.fn.has("persistent_undo") == 1 then
            local target_path = vim.fn.expand("~/.undodir")

            -- Create the directory if it doesn't exist
            if vim.fn.isdirectory(target_path) == 0 then
                vim.fn.mkdir(target_path, "p", 0700)
            end

            -- Set undodir and enable undofile
            vim.o.undodir = target_path
            vim.o.undofile = true
        end

        -- Set keymaps for undotree
        local keymap = vim.keymap -- for conciseness
        keymap.set("n", "<leader><F5>", vim.cmd.UndotreeToggle)
        -- Optional settings
        vim.g.undotree_SetFocusWhenToggle = 1 -- Automatically focus the undo tree window when toggled
    end,
}
