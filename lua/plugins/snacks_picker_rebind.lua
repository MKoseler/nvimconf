return {
    "folke/snacks.nvim",
    keys = {
        {
            "<leader>fg",
            function()
                Snacks.picker.grep()
            end,
            desc = "Find grep",
        },
    },
}
