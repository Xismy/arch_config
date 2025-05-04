return {
	{
		'nvim-orgmode/orgmode',
		dependencies = {
			'akinsho/org-bullets.nvim',
		},
		event = 'VeryLazy',
		ft = { 'org' },
		opts = {
			org_agenda_files = '~/orgfiles/**/*',
			org_default_notes_file = '~/orgfiles/refile.org',
		},
	},
	{
		'akinsho/org-bullets.nvim',
		optional = true,
		opts = {
			headlines = {'', '', '', '', '󰜁', ''},
		} 
	},
}
