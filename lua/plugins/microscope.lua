return {
    {
        "Cpoing/microscope.nvim",
        cmd = "MicroscopePeek",
        keys = {
            { "<leader>p", ":MicroscopePeek<CR>", desc = "Peek definition" },
        },
        config = function()
            require("microscope")
        end,
    },
}
