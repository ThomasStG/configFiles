local opt = vim.opt

vim.opt.grepprg = "rg --vimgrep --smart-case"
opt.grepformat="%f:%l:%c:%m"

opt.relativenumber = true
opt.number = true

opt.termguicolors = true
-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one
opt.softtabstop = 2
opt.wrap = false

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

opt.cursorline = true

-- turn on termguicolors for tokyonight colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position
opt.foldenable = false

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register
-- split windows
opt.splitright = true -- split vertical window to the right opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

vim.g.copilot_enabled = false
vim.g.copilot_no_tab_map = true
vim.g.copilot_filetypes = {
    ["*"] = false, -- Disable Copilot for all filetypes
}
vim.g.transparent_enabled = true

-- Persistent undo
if vim.fn.has("persistent_undo") == 1 then
    local target_path = vim.fn.expand("~/.undodir")
    if vim.fn.isdirectory(target_path) == 0 then
        vim.fn.mkdir(target_path, "p", 0700)
    end
    vim.o.undodir = target_path
    vim.o.undofile = true
end
