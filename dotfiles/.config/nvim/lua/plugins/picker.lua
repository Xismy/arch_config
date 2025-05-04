return {
	{
		"folke/snacks.nvim",
		---@type snacks.Config
		opts = {
			picker = {
			}
		},
		keys = {
			{ "<leader>f", function() Snacks.picker().grep() end, desc = "Find" },
			{ "<leader>f", function() Snacks.picker() end, desc = "Picker" }
		}
	}
}

