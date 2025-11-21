-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
map("n", "<leader>rf", "gq", { desc = "rebind reformat code" })
map("n", "<leader>rn", "<cmd>IncRename<cr>", { desc = "rename lsp" })
map("n", "<leader>td", "<cmd>lua require('dapui').toggle()<cr>", { desc = "toggle nvim-dap-ui" })
map("n", "<leader>tr", "<cmd>JavaTestViewLastReport<cr>", { desc = "view last test report" })
map("n", "<leader>rc", "<cmd>JavaTestDebugCurrentClass<cr>", { desc = "view last test report" })
map("n", "<leader>rm", "<cmd>JavaTestDebugCurrentMethod<cr>", { desc = "view last test report" })
map("n", "<leader>dm", "<cmd>JavaTestRunCurrentMethod<cr>", { desc = "view last test report" })
map("n", "<leader>dc", "<cmd>JavaTestRunCurrentClass<cr>", { desc = "view last test report" })
