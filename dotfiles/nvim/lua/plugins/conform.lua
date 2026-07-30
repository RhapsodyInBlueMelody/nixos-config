return {
  "stevearc/conform.nvim",
  event = 'BufWritePre', -- Load the plugin before saving a buffer
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        -- Your existing C/C++ formatters
        c = { "clang-format" },
        cpp = { "clang-format" },

        -- Python formatting via Ruff (super fast, robust alternative to black/flake8)
        python = { "ruff_fix", "ruff_format" },

        -- Web Development formatting via Prettierd (fast daemon version)
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        javascriptreact = { "prettierd" },
        typescriptreact = { "prettierd" },
        json = { "prettierd" },
        html = { "prettierd" },
        css = { "prettierd" },
        markdown = { "prettierd" },
        yaml = { "prettierd" },

        -- Other tools from your Mason setup
        ruby = { "rubyfmt" },
        nix = { "nixfmt" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback", -- Use LSP formatting as a fallback if no formatter is found
      },
    })
  end,
}

