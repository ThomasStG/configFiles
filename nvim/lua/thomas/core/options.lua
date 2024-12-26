vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")
vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt
opt.relativenumber = true
opt.number = true

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

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

opt.mousescroll = "ver:0,hor:0"
opt.mouse = ""
opt.omnifunc = "v:lua.vim.lsp.omnifunc"
vim.api.nvim_create_user_command(
    "Play", -- Command name
    function()
        vim.cmd("!spotify play/pause >/dev/null") -- Shell command to run
    end,
    { desc = "pause/play spotify" } -- Optional description
)

local state = {
    floating = {
        buf = -1,
        win = -1,
    },
}

local function create_floating_window(opts)
    opts = opts or {}
    local width = opts.width or math.floor(vim.o.columns * 0.8)
    local height = opts.height or math.floor(vim.o.lines * 0.8)

    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)

    local buf = nil
    if vim.api.nvim_buf_is_valid(opts.buf) then
        buf = opts.buf
    else
        buf = vim.api.nvim_create_buf(false, true)
    end

    local win_config = {
        relative = "editor",
        width = width,
        height = height,
        col = col,
        row = row,
        style = "minimal",
        border = "rounded",
    }

    local win = vim.api.nvim_open_win(buf, true, win_config)
    return { buf = buf, win = win }
end

local toggle_terminal = function()
    if not vim.api.nvim_win_is_valid(state.floating.win) then
        state.floating = create_floating_window({ buf = state.floating.buf })
        if vim.bo[state.floating.buf].buftype ~= "terminal" then
            vim.cmd.terminal()
        end
    else
        vim.api.nvim_win_hide(state.floating.win)
    end
end
vim.api.nvim_create_user_command("Floaterminal", toggle_terminal, {})
--local function is_oil_buffer()
--    -- Check if the current buffer is an Oil buffer
--    return vim.bo.filetype == "oil"
--end
--
--local function get_git_branch()
--    local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD"):gsub("\n", "")
--    if branch:find("fatal") then
--        return nil, "Not a Git repository"
--    end
--    return branch
--end
--
---- Variable to store the last saved undo state
--local last_saved_undo_hash = nil
--
--local function get_current_undo_hash()
--    local undo_info = vim.fn.undotree()
--    local curhead = undo_info.curhead
--    if not curhead then
--        return "root" -- Assign a static name for the root state
--    end
--    return curhead
--end
----
--local function generate_branch_name(undo_number, filepath)
--    local filename = vim.fn.fnamemodify(filepath, ":t") -- Get the file's base name
--    return string.format("undo_%s_%d", filename, undo_number) -- Format: undo_<filename>_<undo_number>
--end
--local function save_to_git()
--    if is_oil_buffer() then
--        return
--    end
--
--    local filepath = vim.fn.expand("%:p")
--    if filepath == "" then
--        return
--    end
--
--    local current_undo = get_current_undo_hash()
--
--    -- Check if the current undo state differs from the last saved state
--    if current_undo ~= last_saved_undo_hash then
--        local branch_name = generate_branch_name(current_undo, filepath)
--        local current_branch, err = get_git_branch()
--        if not current_branch then
--            return
--        end
--
--        -- Switch to the new branch if necessary
--        if current_branch ~= branch_name then
--            local branch_cmd =
--                string.format("git checkout -b %s 2>/dev/null || git checkout %s", branch_name, branch_name)
--            vim.fn.system(branch_cmd)
--        end
--
--        -- Check if the file has changes before staging and committing
--        local status_cmd = string.format("git status --porcelain %s", vim.fn.shellescape(filepath))
--        local status_output = vim.fn.system(status_cmd)
--
--        if status_output ~= "" then -- If there are changes
--            -- Stage and commit changes
--            local stage_cmd = "git add " .. vim.fn.shellescape(filepath)
--            vim.fn.system(stage_cmd)
--
--            local commit_msg = string.format("Undo state: %s", current_undo)
--            local commit_output = vim.fn.system("git commit -m " .. vim.fn.shellescape(commit_msg))
--        end
--
--        -- Update the last saved undo state
--        last_saved_undo_hash = current_undo
--    end
--end
--
---- Attach the save_to_git function to the BufWritePost event
--vim.api.nvim_create_autocmd("BufWritePost", {
--    pattern = "*",
--    callback = save_to_git,
--})
---- Function to run git add and commit before quitting
--local function git_add_and_commit()
--    -- Stage all changes with git add
--    local add_cmd = "git add ."
--    vim.fn.system(add_cmd)
--
--    -- Commit the changes with a message
--    local commit_msg = "auto save on quit"
--    local commit_cmd = string.format('git commit -m "%s"', commit_msg)
--    vim.fn.system(commit_cmd)
--end
--
---- Create an autocommand to run git add and commit when quitting
--vim.api.nvim_create_autocmd("BufWritePre", {
--    pattern = "*",
--    callback = git_add_and_commit,
--})
--
---- Map :wqa to include git add and commit before quitting
--vim.api.nvim_create_user_command("Wqa", function()
--    git_add_and_commit()
--    vim.cmd("wqa") -- Execute :wqa after git add and commit
