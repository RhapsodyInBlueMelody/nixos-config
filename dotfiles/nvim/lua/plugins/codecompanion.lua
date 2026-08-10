return {
	"olimorris/codecompanion.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
	opts = {
		adapters = {
			http = {
				openwebui = function()
					return require("codecompanion.adapters").extend("openai_compatible", {
						env = {
							url = "http://localhost:8080",
							api_key = "sk-22e3da5d89354993b601484e102f81d9",
						},
						schema = {
							model = { default = "faiz-assistant-7b:latest" },
							num_ctx = { default = 16384 },
						},
					})
				end,
			},
		},
		interactions = {
			chat = { adapter = "openwebui" },
			inline = { adapter = "openwebui" },
		},
	},
	keys = {
		{ "<leader>a", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" } },
		{ "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" } },
	},
}
