return {
  "simnalamburt/vim-mundo", -- Install the vim-mundo plugin

  -- Key mappings
  keys = {
    { "<leader>t", ":MundoToggle<CR>", desc = "Show/Hide undo tree" },
  },

  -- Additional settings
  setup = function()
    vim.opt.undofile = true -- Enable persistent undo
    vim.opt.undodir = "~/.vim/undo" -- Set the undo directory
  end,
}
