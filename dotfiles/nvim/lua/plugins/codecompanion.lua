return {
	"olimorris/codecompanion.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
	opts = {
		interactions = { -- verify against :h codecompanion for your installed version
			chat = { adapter = "ollama" },
			inline = { adapter = "ollama" },
		},
		adapters = {
			http = {
				ollama = function()
					return require("codecompanion.adapters").extend("ollama", {
						schema = {
							model = { default = "qwen2.5-coder:7b-instruct-q4_K_M" },
							num_ctx = { default = 16384 },
						},
					})
				end,
			},
		},
	},
	keys = {
		{ "<leader>a", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" } },
		{ "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" } },
	},
}
