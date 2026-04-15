return {
	{
		"nvim-mini/mini.completion",
		version = "*",
		dependencies = {
			"nvim-mini/mini.snippets",
		},
		opts = {},
	},
	{
		"nvim-mini/mini.snippets",
		version = "*",
		opts = function(_, _)
			local gen_loader = require("mini.snippets").gen_loader
			return {
				snippets = {
					gen_loader.from_file("~/.config/nvim/snippets/global.json"),
				},
			}
		end,
	},
}
