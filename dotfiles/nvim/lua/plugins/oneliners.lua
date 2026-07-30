-- lua/plugins/oneliners.lua
return {
    {
        "sphamba/smear-cursor.nvim",
        opts = {},
    },
    {
        'tpope/vim-rails'
    },
    {
        'ThePrimeagen/vim-be-good'
    },
    {
        'ojroques/vim-oscyank',
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "gruvbox",
                },
            })
        end,
    },
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            require("bufferline").setup({})
        end,
    },
    {
        'tpope/vim-fugitive',
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end,
    },
    {
        'brenoprata10/nvim-highlight-colors',
        config = function()
            require('nvim-highlight-colors').setup({})
        end
    },
    {
        'mbbill/undotree',
        config = function()
            vim.keymap.set("n", "<leader><F5>", vim.cmd.UndotreeToggle)
        end,
    },
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({})
        end,
    },
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        config = function()
            require("which-key").setup({})
        end,
    },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("trouble").setup({})
        end,
    },
    -- File explorer
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        keys = {
            { "<leader>pv", ":Neotree toggle<CR>", desc = "Toggle Neo-tree" },
            { "<leader>pe", ":Neotree focus<CR>",  desc = "Focus Neo-tree" },
            { "<leader>pp", "<C-w>p",              desc = "Focus Previous Window" },
        },
        config = function()
            require("neo-tree").setup({
                close_if_last_window = false,
                popup_border_style = "rounded",
                enable_git_status = true,
                enable_diagnostics = true,
                window = {
                    position = "right",
                    width = 20,
                },
                filesystem = {
                    filtered_items = {
                        visible = false,
                        hide_dotfiles = false,
                        hide_gitignored = true,
                        hide_hidden = false,
                    },
                    follow_current_file = {
                        enabled = true,
                    },
                    use_libuv_file_watcher = true,
                },
            })
        end,
    },
}
