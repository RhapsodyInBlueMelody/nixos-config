return {
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        keys = {
            {
                "<leader>mp",
                function()
                    require("conform").format({ lsp_fallback = true })
                end,
                mode = "",
                desc = "Format buffer",
            },
        },
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    lua = { "stylua" },
                    python = { "black", "isort" },
                    ruby = { "rubocop" },
                    javascript = { "prettierd", "prettier" },
                    typescript = { "prettierd", "prettier" },
                    javascriptreact = { "prettierd", "prettier" },
                    typescriptreact = { "prettierd", "prettier" },
                    css = { "prettierd", "prettier" },
                    scss = { "prettierd", "prettier" },
                    html = { "prettierd", "prettier" },
                    json = { "prettierd", "prettier" },
                    jsonc = { "prettierd", "prettier" },
                    yaml = { "prettierd", "prettier" },
                    markdown = { "prettierd", "prettier" },
                    c = { "clang_format" },
                    cpp = { "clang_format" },
                    rust = { "rustfmt" },
                },
                format_on_save = function(bufnr)
                    -- Disable with a global or buffer-local variable
                    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                        return
                    end
                    return {
                        timeout_ms = 500,
                        lsp_fallback = true,
                    }
                end,
                formatters = {
                    rubocop = {
                        command = "rubocop",
                        args = { "--auto-correct", "--format", "quiet", "--stderr", "--stdin", "$FILENAME" },
                        stdin = true,
                    },
                    black = {
                        prepend_args = { "--fast" },
                    },
                    prettier = {
                        prepend_args = { "--tab-width", "2" },
                    },
                    prettierd = {
                        prepend_args = { "--tab-width", "2" },
                    },
                },
            })

            -- Create commands to disable/enable formatting
            vim.api.nvim_create_user_command("FormatDisable", function(args)
                if args.bang then
                    -- FormatDisable! will disable formatting just for this buffer
                    vim.b.disable_autoformat = true
                else
                    vim.g.disable_autoformat = true
                end
            end, {
                desc = "Disable autoformat-on-save",
                bang = true,
            })

            vim.api.nvim_create_user_command("FormatEnable", function()
                vim.b.disable_autoformat = false
                vim.g.disable_autoformat = false
            end, {
                desc = "Re-enable autoformat-on-save",
            })
        end,
    },
}
