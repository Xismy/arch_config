return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "VeryLazy",
	opts = {
		suggestion = {
			enabled = true,
			auto_trigger = false,
			keymap = {
				accept = "<C-l>",
				next = "<C-j>",
				prev = "<C-k>",
			},
		},
	}
}
