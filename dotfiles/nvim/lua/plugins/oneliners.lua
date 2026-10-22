return {
    -- Statusline & Buffers
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            options = { theme = "gruvbox" },
        },
    },
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {},
    },

    -- Git Integration
    {
        "lewis6991/gitsigns.nvim",
        opts = {},
    },

    -- Developer Utilities
    {
        "brenoprata10/nvim-highlight-colors",
        opts = {},
    },
    {
        "mbbill/undotree",
        config = function()
            vim.keymap.set("n", "<leader><F5>", vim.cmd.UndotreeToggle)
        end,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {},
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {},
    },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {},
    },

    -- Framework Specific
    { "tpope/vim-rails", ft = "ruby" },
}
