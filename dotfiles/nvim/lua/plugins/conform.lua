-- conform.lua
return {
	"stevearc/conform.nvim",
	event = { "BufWritePre", "BufNewFile" },
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
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "ruff_fix", "ruff_format" },
			ruby = { "rubocop" },
			javascript = { "prettierd" },
			typescript = { "prettierd" },
			javascriptreact = { "prettierd" },
			typescriptreact = { "prettierd" },
			json = { "prettierd" },
			html = { "prettierd" },
			css = { "prettierd" },
			markdown = { "prettierd" },
			yaml = { "prettierd" },
			c = { "clang_format" },
			cpp = { "clang_format" },
			rust = { "rustfmt" },
			nix = { "nixfmt" },
		},
		formatters = {
			nixfmt = {
				command = "nixfmt",
				args = { "-" },
			},
			rubocop = {
				command = "rubocop",
				args = { "--auto-correct", "--format", "quiet", "--stderr", "--stdin", "$FILENAME" },
				stdin = true,
			},
			prettierd = { prepend_args = { "--tab-width", "2" } },
		},
		format_on_save = function(bufnr)
			if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
				return
			end
			return { timeout_ms = 500, lsp_format = "fallback" }
		end,
	},
}
