return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			explorer = {
				replace_netrw = true,
			},

			picker = {
				sources = {
					explorer = {
						win = {
							input = {
								keys = {
									["<esc>"] = { function()
										vim.api.nvim_buf_set_lines(
											vim.api.nvim_get_current_buf(), 
											0, -1, false, {""})
									end, mode = "n" }
								},
							},
							list = {
								keys = {
									["<esc>"] = { "", mode = "n" },
								},
							},
						}
					},
				},
			},
		},
		keys = {
			{ "<leader>e", function() Snacks.explorer() end, desc = "Explorer" },
		},
	},
}
