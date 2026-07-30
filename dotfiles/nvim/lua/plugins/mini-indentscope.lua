return {
    {
        "echasnovski/mini.indentscope",
        version = false,
        config = function()
            require('mini.indentscope').setup({
                draw = {
                    animation = require('mini.indentscope').gen_animation.cubic({
                        easing = 'in-out',
                        duration = 15,
                        unit = 'step',
                    }),
                },
                symbol = "│",
                options = { try_as_border = true },
            })

            -- Set default (inactive) color: gray
            vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#666666" })

            -- Set active scope color: blue (or whatever you like)
            vim.api.nvim_set_hl(0, "MiniIndentscopeSymbolActive", { fg = "#61AFEF" })
        end,
    }
}
