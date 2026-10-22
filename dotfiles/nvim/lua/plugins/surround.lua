return {
    {
        "kylechui/nvim-surround",
        version = "*", -- Pin to stable releases
        event = "VeryLazy",
        opts = {
            -- Default settings handle:
            --   ys (add surround), ds (delete surround), cs (change surround)
            --   ( adds spaces: ( text )
            --   ) adds no spaces: (text)
            highlight = {
                duration = 0,
            },
            move_cursor = "begin",
        },
    },
}
