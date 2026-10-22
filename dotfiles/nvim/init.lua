-- 1. Load options first (critical for mapleader and fundamental options)
require("config.options")

-- 2. Bootstrap/Load plugins (Lazy will manage Gruvbox lazily or at startup)
require("config.lazy")

-- 3. Load keymaps after plugins/options
require("config.mappings")

-- 4. Global Autocommands
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank
augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
    group = "YankHighlight",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 300 })
    end,
})

-- Format on save (Pre-write, not Post-write)
augroup("FormatAutogroup", { clear = true })
autocmd("BufWritePre", {
    group = "FormatAutogroup",
    callback = function(args)
        require("conform").format({ bufnr = args.buf, lsp_fallback = true })
    end,
})

-- 5. Global Diagnostic Config
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true, -- Set to true so Error takes precedence visually over Hint/Info
})
