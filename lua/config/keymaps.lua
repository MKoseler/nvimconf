-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
local ergoterm = require("ergoterm")
local mvntest = ergoterm:new({
    auto_list = false,
    bang_target = false,
    sticky = true,
    layout = "below",
    size = {
        below = "20%",
    },
    auto_scroll = true,
})

local function splitFileName(inputstr)
    for str in string.gmatch(inputstr, "([^" .. "." .. "]+)") do
        return str
    end
end

local widgets = require("dap.ui.widgets")
local dap = require("dap")

-- disabale c-b neovim default key so we can use it for spelunk
map("n", "<C-b>", "<C-ü>")
-- disable copilot and get suggestions with keypress
map("n", "<leader>cp", "<cmd>Copilot suggestion next<cr>", { desc = "copilot suggestion" })
map("n", "<leader>rn", "<cmd>lua require('live-rename').rename()<cr>viw", { desc = "rename lsp" })
-- debug hotkeys - ui
map("n", "<leader>dt", "<cmd>lua require('dapui').toggle()<cr>", { desc = "toggle terminal", remap = true })
map("n", "<leader>ds", function()
    widgets.sidebar(widgets.scopes).toggle()
end, { desc = "toggle scopes", remap = true })
map("n", "<leader>db", "<cmd>DapToggleBreakpoint<cr>", { desc = "toggle breakpoint" })
map("n", "<leader>dm", "<cmd>lua require'jdtls'.test_nearest_method()<cr>", { desc = "toggle breakpoint" })
map("n", "<leader>de", function()
    widgets.hover()
end, { desc = "eval expression under curor" })
map("n", "<leader>df", function()
    widgets.centered_float(widgets.frames).open()
end, { desc = "float debug element" })
map("n", "<leader>dc", "<cmd>lua require'jdtls'.test_class()<cr>", { desc = "toggle breakpoint" })
-- debug hotkeys - steps
map("n", "<leader>di", function()
    dap.step_into()
end, { desc = "debug step into" })
map("n", "<leader>do", function()
    dap.step_out()
end, { desc = "debug step out" })
map("n", "<leader>dO", function()
    dap.step_over()
end, { desc = "debug step over" })
map("n", "<leader>dk", function()
    dap.terminate()
    dap.disconnect()
    vim.cmd.DapVirtualTextForceRefresh()
end, { desc = "debug kill session" })
-- run mvn tests - expected to have surefire-tree plugin installed
map("n", "<leader>mm", function()
    mvntest:send({
        "mvn test -Dtest="
            .. splitFileName(vim.fs.basename(vim.fn.expand("%")))
            .. "#"
            .. vim.fn.expand("<cword>")
            .. " -Dsurefire.useFile=false",
    }, { action = "open" })
end, { desc = "Test single test" })
map("n", "<leader>mc", function()
    mvntest:send(
        { "mvn test -Dtest=" .. splitFileName(vim.fs.basename(vim.fn.expand("%"))) .. " -Dsurefire.useFile=false" },
        { action = "open" }
    )
end, { desc = "Test single test class" })
-- tmux
map("n", "<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>", { desc = "tmux left" })
map("n", "<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>", { desc = "tmux down" })
map("n", "<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>", { desc = "tmux up" })
map("n", "<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>", { desc = "tmux right" })
