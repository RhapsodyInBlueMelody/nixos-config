-- lua/plugins/surround.lua
return {
    {
        "kylechui/nvim-surround",
        version = "*", -- Keeps you on stable releases
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- KEYMAPS: Removed entirely. v4 sets these defaults automatically.
                -- If you want to DISABLE a specific keymap, you now set it to false.

                surrounds = {
                    -- Custom surrounds (e.g., adding spaces with closing paren)
                    ["("] = {
                        add = { "(", ")" },
                    },
                    [")"] = {
                        add = { "( ", " )" },
                    },
                },
                aliases = {
                    ["a"] = ">",
                    ["b"] = ")",
                    ["B"] = "}",
                    ["r"] = "]",
                    ["q"] = { '"', "'", "`" },
                    ["s"] = { "}", "]", ")", ">", '"', "'", "`" },
                },
                highlight = {
                    duration = 0,
                },
                move_cursor = "begin",
            })
        end,
    },
}
