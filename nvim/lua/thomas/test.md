1 ╭───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
~ │  15:13:36 │
~ │━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━│
~ │stack traceback: │
~ │ .../share/nvim/lazy/nvim-ts-autotag/lua/nvim-ts-autotag.lua:18: in function 'attach' │
~ │ ...vim/lazy/nvim-treesitter/lua/nvim-treesitter/configs.lua:509: in function 'attach_module' │
~ │ ...vim/lazy/nvim-treesitter/lua/nvim-treesitter/configs.lua:532: in function 'reattach_module' │
~ │ ...vim/lazy/nvim-treesitter/lua/nvim-treesitter/configs.lua:133: in function <...vim/lazy/nvim-treesitter/lua/nvim-treesitter/configs.lua:132│
~ │ [C]: in function 'nvim_exec_autocmds' │
~ │ ...hare/nvim/lazy/lazy.nvim/lua/lazy/core/handler/event.lua:161: in function <...hare/nvim/lazy/lazy.nvim/lua/lazy/core/handler/event.lua:160│
~ │ [C]: in function 'xpcall' │
~ │ .../.local/share/nvim/lazy/lazy.nvim/lua/lazy/core/util.lua:135: in function 'try' │
~ │ ...hare/nvim/lazy/lazy.nvim/lua/lazy/core/handler/event.lua:160: in function 'trigger' │
~ │ ...hare/nvim/lazy/lazy.nvim/lua/lazy/core/handler/event.lua:89: in function <...hare/nvim/lazy/lazy.nvim/lua/lazy/core/handler/event.lua:72> │
~ │ [C]: in function 'nvim_cmd' │
~ │ ...w/Cellar/neovim/0.10.4_1/share/nvim/runtime/filetype.lua:36: in function <...w/Cellar/neovim/0.10.4_1/share/nvim/runtime/filetype.lua:35> │
~ │ [C]: in function 'nvim_buf_call' │
~ │ ...w/Cellar/neovim/0.10.4_1/share/nvim/runtime/filetype.lua:35: in function <...w/Cellar/neovim/0.10.4_1/share/nvim/runtime/filetype.lua:10> │

    1 ┊ 1                                             │  lazy.nvim                                                                                                                                          15:13:36 │
    2 ~                                               │━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━│
    3 ~                                               │Failed to run config for obsidian.nvim                                                                                                                         │
    4 ~                                               │                                                                                                                                                               │
    5 ~                                               │...ocal/share/nvim/lazy/obsidian.nvim/lua/obsidian/path.lua:402: FileNotFoundError: Users/thomas/Library/Mobile Documents/iCloudmdobsidian/Documents/Personal  │
    6 ~                                               │                                                                                                                                                               │
    7 ~                                               │# stacktrace:                                                                                                                                                  │
    8 ~                                               │  - /obsidian.nvim/lua/obsidian/path.lua:402 in resolve                                                                                                        │
    9 ~                                               │  - /obsidian.nvim/lua/obsidian/workspace.lua:79 in new_from_spec                                                                                              │

10 ~ │ - /obsidian.nvim/lua/obsidian/workspace.lua:169 in get_workspace_for_cwd │
11 ~ │ - /obsidian.nvim/lua/obsidian/workspace.lua:206 in get_from_opts │
12 ~ │ - /obsidian.nvim/lua/obsidian/client.lua:93 in new │
13 ~ │ - /obsidian.nvim/lua/obsidian/init.lua:95 in setup │
14 ~ │ - /opt/homebrew/Cellar/neovim/0.10.4_1/share/nvim/runtime/filetype.lua:36 │
15 ~ │ - /opt/homebrew/Cellar/neovim/0.10.4_1/share/nvim/runtime/filetype.lua:35 │
