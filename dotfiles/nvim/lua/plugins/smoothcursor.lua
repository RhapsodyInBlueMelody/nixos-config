return {
    "gen740/SmoothCursor.nvim",
    config = function()
        require("smoothcursor").setup({
            type = "default",  -- Try "default", "exp", "matrix", "sonic", "pixiedust", etc.
            fancy = {
                enable = true, -- enables the flame/flare
                head = { cursor = "▷", color = "#fabd2f", texthl = "SmoothCursor", linehl = nil },
                body = {
                    { cursor = "●", color = "#fe8019" },
                    { cursor = "●", color = "#d3869b" },
                    { cursor = "•", color = "#b8bb26" },
                    { cursor = ".", color = "#8ec07c" },
                },
                tail = { cursor = nil, color = nil },
            },
            autostart = true,
            always_redraw = true,
            flyin_effect = "bottom",
            speed = 25,
            intervals = 35,
            priority = 10,
            timeout = 3000,
            threshold = 3,
            disable_float_win = false,
        })
    end,
}
