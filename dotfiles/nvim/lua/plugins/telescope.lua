-- lua/plugins/telescope.lua
return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>",  desc = "Find Files" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>",   desc = "Live Grep" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>",     desc = "Find Buffers" },
            { "<leader>fh", "<cmd>Telescope help_tags<cr>",   desc = "Help Tags" },
            { "<leader>fr", "<cmd>Telescope oldfiles<cr>",    desc = "Recent Files" },
            { "<leader>fc", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme" },
            { "<leader>fs", "<cmd>Telescope grep_string<cr>", desc = "Find String" },
            { "<leader>fm", "<cmd>Telescope marks<cr>",       desc = "Marks" },
            { "<leader>fj", "<cmd>Telescope jumplist<cr>",    desc = "Jumplist" },
            { "<leader>fk", "<cmd>Telescope keymaps<cr>",     desc = "Keymaps" },
            { "<leader>ft", "<cmd>Telescope treesitter<cr>",  desc = "Treesitter" },
        },
        config = function()
            local telescope = require("telescope")
            local actions = require("telescope.actions")

            telescope.setup({
                defaults = {
                    path_display = { "truncate" },
                    file_ignore_patterns = {
                        "%.git/",
                        "node_modules/",
                        "%.npm/",
                        "%.cache/",
                        "dist/",
                        "build/",
                        "target/",
                        "%.o",
                        "%.a",
                        "%.out",
                        "%.class",
                        "%.pdf",
                        "%.mkv",
                        "%.mp4",
                        "%.zip",
                    },
                    mappings = {
                        i = {
                            ["<C-n>"] = actions.cycle_history_next,
                            ["<C-p>"] = actions.cycle_history_prev,
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous,
                            ["<C-c>"] = actions.close,
                            ["<Down>"] = actions.move_selection_next,
                            ["<Up>"] = actions.move_selection_previous,
                            ["<CR>"] = actions.select_default,
                            ["<C-x>"] = actions.select_horizontal,
                            ["<C-v>"] = actions.select_vertical,
                            ["<C-t>"] = actions.select_tab,
                            ["<C-u>"] = actions.preview_scrolling_up,
                            ["<C-d>"] = actions.preview_scrolling_down,
                            ["<PageUp>"] = actions.results_scrolling_up,
                            ["<PageDown>"] = actions.results_scrolling_down,
                            ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                            ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                            ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                            ["<C-l>"] = actions.complete_tag,
                            ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
                        },
                        n = {
                            ["<esc>"] = actions.close,
                            ["<CR>"] = actions.select_default,
                            ["<C-x>"] = actions.select_horizontal,
                            ["<C-v>"] = actions.select_vertical,
                            ["<C-t>"] = actions.select_tab,
                            ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                            ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                            ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                            ["j"] = actions.move_selection_next,
                            ["k"] = actions.move_selection_previous,
                            ["H"] = actions.move_to_top,
                            ["M"] = actions.move_to_middle,
                            ["L"] = actions.move_to_bottom,
                            ["<Down>"] = actions.move_selection_next,
                            ["<Up>"] = actions.move_selection_previous,
                            ["gg"] = actions.move_to_top,
                            ["G"] = actions.move_to_bottom,
                            ["<C-u>"] = actions.preview_scrolling_up,
                            ["<C-d>"] = actions.preview_scrolling_down,
                            ["<PageUp>"] = actions.results_scrolling_up,
                            ["<PageDown>"] = actions.results_scrolling_down,
                            ["?"] = actions.which_key,
                        },
                    },
                },
                pickers = {
                    find_files = {
                        hidden = true,
                        find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
                    },
                    live_grep = {
                        additional_args = function(opts)
                            return { "--hidden" }
                        end
                    },
                },
                extensions = {
                    -- Add extensions here if needed
                },
            })
        end,
    },
}
