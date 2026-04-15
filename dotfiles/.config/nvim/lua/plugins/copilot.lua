return {
	{
		"zbirenbaum/copilot.lua",
		enabled = false,
		cmd = "Copilot",
		event = "VeryLazy",
		opts = {
			suggestion = {
				enabled = true,
				auto_trigger = false,
				keymap = {
					--accept = "<C-l>",
					--next = "<C-j>",
					--prev = "<C-k>",
				},
			},
		}
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			"zbirenbaum/copilot.lua",
			{"nvim-lua/plenary.nvim", branch = "master"},
		},
		build = "make tiktoken",
		opts = {},
	}
}
