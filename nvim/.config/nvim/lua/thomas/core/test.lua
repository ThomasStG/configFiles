local chat_history_file = vim.fn.stdpath("data") .. "/ai_chat_history.json"

-- Load chat history from file
local function load_chat_history()
    local f = io.open(chat_history_file, "r")
    if not f then
        return {}
    end
    local content = f:read("*all")
    f:close()
    return vim.fn.json_decode(content) or {}
end

-- Save chat history to file
local function save_chat_history(history)
    local f = io.open(chat_history_file, "w")
    if f then
        f:write(vim.fn.json_encode(history))
        f:close()
    end
end

-- Auto-start the Ollama server
local llama_handle = nil
local function start_llama_server()
    if llama_handle ~= nil then
        print("LLaMA server is already running!")
        return
    end

    llama_handle = vim.loop.spawn("ollama", {
        args = { "serve" }, -- Start the Ollama server
        stdio = { nil, nil, nil }, -- No need for stdin, stdout, stderr
    }, function(code, signal)
        print("LLaMA server exited with code:", code, "and signal:", signal)
        llama_handle = nil
    end)

    if llama_handle then
        print("LLaMA server started successfully!")
    else
        print("Failed to start LLaMA server.")
    end
end

-- Auto-stop the server when Neovim exits
local function stop_llama_server()
    if llama_handle ~= nil then
        llama_handle:kill("sigterm") -- Send SIGTERM to the server
        print("LLaMA server shut down.")
        llama_handle = nil
    else
        print("No LLaMA server to shut down.")
    end
end

-- Auto-start the server when Neovim launches
vim.api.nvim_create_autocmd("VimEnter", {
    callback = start_llama_server,
})

-- Ensure the server stops when Neovim exits
vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = stop_llama_server,
})

-- Command to manually save the chat history
vim.api.nvim_create_user_command("SaveChat", function()
    local chat_history = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    save_chat_history(chat_history)
    print("Chat history saved.")
end, {})
-- local function format_code_and_text_mixed(response)
--   local formatted = {}
--   local in_code_block = false
--
--   for line in response:gmatch("[^\r\n]+") do
--     -- Check if the line starts or ends a code block
--     if line:match("^```") then
--       -- Toggle the code block state
--       if in_code_block then
--         table.insert(formatted, "```") -- End the current code block
--         in_code_block = false
--       else
--         table.insert(formatted, "```") -- Start a new code block
--         in_code_block = true
--       end
--     elseif in_code_block then
--       -- Add lines inside a code block
--       table.insert(formatted, line)
--     else
--       -- Detect potential code lines outside of code blocks
--       if line:match("^%s*%w+%s*%(") or line:match("^%s*{") or line:match(";$") then
--         if not in_code_block then
--           table.insert(formatted, "```") -- Start code block
--           in_code_block = true
--         end
--         table.insert(formatted, line)
--       else
--         if in_code_block then
--           table.insert(formatted, "```") -- End code block
--           in_code_block = false
--         end
--         table.insert(formatted, line) -- Plain text
--       end
--     end
--   end
--
--   -- Close any open code block
--   if in_code_block then
--     table.insert(formatted, "```")
--   end
--
--   return table.concat(formatted, "\n")
-- end
