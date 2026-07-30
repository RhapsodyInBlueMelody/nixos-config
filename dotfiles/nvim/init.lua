require('config.lazy')
require('config.mappings')
require('config.options')
vim.o.background = "dark"

require("gruvbox").setup({
    terminal_colors = true, -- add neovim terminal colors
    undercurl = true,
    underline = true,
    bold = true,
    italic = {
        strings = true,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
    },
    strikethrough = true,
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    inverse = true, -- invert background for search, diffs, statuslines and errors
    contrast = "",  -- can be "hard", "soft" or empty string
    palette_overrides = {},
    overrides = {},
    dim_inactive = false,
    transparent_mode = false,
})

vim.cmd([[colorscheme gruvbox]])

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
    group = "YankHighlight",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = "300" })
    end,
})

augroup("FormatAutogroup", { clear = true })
autocmd("BufWritePost", {
    group = "FormatAutogroup",
    callback = function()
        require("conform").format({ lsp_fallback = true })
    end,
})

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = false,
})

vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#444444" })       -- Inactive: grey
vim.api.nvim_set_hl(0, "MiniIndentscopeSymbolActive", { fg = "#61AFEF" }) -- Active: blue (or any color you want)

-- Add nil server configuration
vim.lsp.config("nil", {
    settings = {
        ["nil"] = {
            formatting = {
                command = { "nixfmt" }, -- Uses the nixfmt executable installed via Nix
            },
        },
    },
})
vim.lsp.enable("nil")
