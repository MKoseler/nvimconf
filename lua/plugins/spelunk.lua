return {
    "EvWilson/spelunk.nvim",
    dependencies = {
        "folke/snacks.nvim",
        "nvim-lualine/lualine.nvim",
    },
    config = function()
        require("spelunk").setup({
            enable_persist = false,
            fuzzy_search_provider = "snacks",
            base_mappings = {
                search_current_bookmarks = "<C-b>",
            },
        })
        require("spelunk").filename_formatter = function(abspath)
            return vim.fn.fnamemodify(abspath, ":t")
        end
    end,
}
