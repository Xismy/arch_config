return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*", 
			build = "make install_jsregexp"
		},
		"saadparwaiz1/cmp_luasnip"
	},
	opts = function ()
		local cmp = require("cmp")
		return {
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
			}),
			sources = cmp.config.sources(
				{
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				},
				{
					{ name = "buffer" }
				}
			)
		}
	end
}
