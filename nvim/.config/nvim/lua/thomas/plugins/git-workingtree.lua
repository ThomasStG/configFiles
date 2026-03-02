return {
    "ThePrimeagen/git-worktree.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        -- Import git-worktree
        local Worktree = require("git-worktree")

        -- Configure git-worktree
        Worktree.setup({
            change_directory_command = "z",
            update_on_change = true,
            clearjumps_on_change = true,
        })

        -- Handle worktree events
        Worktree.on_tree_change(function(op, metadata)
            if op == Worktree.Operations.Switch then
                print("Switched to worktree: " .. metadata.path)
            elseif op == Worktree.Operations.Create then
                print("Created a new worktree: " .. metadata.path)
            elseif op == Worktree.Operations.Delete then
                print("Deleted a worktree: " .. metadata.path)
            end
        end)
    end,
}
