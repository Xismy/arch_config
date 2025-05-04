return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			explorer = {
				replace_netrw = true,
			}
		},
		keys = {
			{ "<leader>e", function() Snacks.explorer() end, desc = "Explorer" }
		}
	}
}
