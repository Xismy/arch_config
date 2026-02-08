return {
	{
		"folke/snacks.nvim",
		---@type snacks.Config
		opts = {
			picker = {
			},
		},
		keys = {
			{ "<leader>f", group = "Find" },
			{ "<leader>ff", function() Snacks.picker.files() end, desc = "Files" },
			{ "<leader>fg", function() Snacks.picker.grep() end, desc = "Grep" },
			{ "<leader>fw", function() Snacks.picker.grep_word() end, desc = "Grep Word" },
			{ "<leader>fs", function() Snacks.picker() end, desc = "Select picker" },
			{ "<leader>fr", function() Snacks.picker.resume() end, desc = "Resume" },
			{ "<leader>l", group = "LSP" },
			{ "<leader>lr", function() Snacks.picker.lsp_references() end, desc = "Find References" },
		},
	},
}

