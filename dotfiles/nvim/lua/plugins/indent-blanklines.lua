return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    init = function()
        local function set_ibl_highlights()
            vim.api.nvim_set_hl(0, "IblIndentLevel1", { fg = "#fb4934" }) -- red
            vim.api.nvim_set_hl(0, "IblIndentLevel2", { fg = "#fe8019" }) -- orange
            vim.api.nvim_set_hl(0, "IblIndentLevel3", { fg = "#fabd2f" }) -- yellow
            vim.api.nvim_set_hl(0, "IblIndentLevel4", { fg = "#b8bb26" }) -- green
            vim.api.nvim_set_hl(0, "IblIndentLevel5", { fg = "#8ec07c" }) -- aqua
            vim.api.nvim_set_hl(0, "IblIndentLevel6", { fg = "#83a598" }) -- blue

            vim.api.nvim_set_hl(0, "IblScopeLevel1", { fg = "#fb4934", bold = true })
            vim.api.nvim_set_hl(0, "IblScopeLevel2", { fg = "#fe8019", bold = true })
            vim.api.nvim_set_hl(0, "IblScopeLevel3", { fg = "#fabd2f", bold = true })
            vim.api.nvim_set_hl(0, "IblScopeLevel4", { fg = "#b8bb26", bold = true })
            vim.api.nvim_set_hl(0, "IblScopeLevel5", { fg = "#8ec07c", bold = true })
            vim.api.nvim_set_hl(0, "IblScopeLevel6", { fg = "#83a598", bold = true })
        end

        set_ibl_highlights()

        -- Redefine highlights after every colorscheme change
        vim.api.nvim_create_autocmd("ColorScheme", {
            callback = function()
                set_ibl_highlights()
            end,
        })
    end,
    config = function()
        require("ibl").setup({
            indent = {
                char = "│",
                highlight = {
                    "IblIndentLevel1",
                    "IblIndentLevel2",
                    "IblIndentLevel3",
                    "IblIndentLevel4",
                    "IblIndentLevel5",
                    "IblIndentLevel6",
                },
            },
            scope = {
                enabled = true,
                show_start = true,
                show_end = true,
                highlight = {
                    "IblScopeLevel1",
                    "IblScopeLevel2",
                    "IblScopeLevel3",
                    "IblScopeLevel4",
                    "IblScopeLevel5",
                    "IblScopeLevel6",
                },
            },
        })
    end,
}
