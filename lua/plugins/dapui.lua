return {
    "rcarriga/nvim-dap-ui",
    config = function()
        require("dapui").setup({
            icons = { expanded = "", collapsed = "", current_frame = "" },
            mappings = {
                -- Use a table to apply multiple mappings
                expand = { "<CR>", "<2-LeftMouse>" },
                open = "o",
                remove = "d",
                edit = "e",
                repl = "r",
                toggle = "t",
            },
            element_mappings = {},
            expand_lines = vim.fn.has("nvim-0.7") == 1,
            force_buffers = true,
            layouts = {
                {
                    elements = {
                        "console",
                    },
                    size = 50,
                    position = "bottom", -- Can be "bottom" or "top"
                },
            },
            floating = {
                max_height = nil,
                max_width = nil,
                border = "single",
                mappings = {
                    ["close"] = { "q", "<Esc>" },
                },
            },
            controls = {
                enabled = vim.fn.exists("+winbar") == 1,
                element = "repl",
                icons = {
                    pause = "",
                    play = "",
                    step_into = "",
                    step_over = "",
                    step_out = "",
                    step_back = "",
                    run_last = "",
                    terminate = "",
                    disconnect = "",
                },
            },
            render = {
                max_type_length = nil, -- Can be integer or nil.
                max_value_lines = nil, -- Can be integer or nil.
                indent = 1,
            },
        })
    end,
}
