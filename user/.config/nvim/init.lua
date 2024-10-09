local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
	"git",
        "clone",
	"--filter=blob:none",
	"https://github.com/folke/lazy.nvim.git",
	"--branch=stable", -- latest stable release
	lazypath,
    })
end


local o = vim.opt
o.number = true
o.wrap = false
o.hidden = true
o.termguicolors = true
o.cursorline = true
o.guicursor = 'n-v-c-sm:hor20,i-ci-ve:ver25,r-cr-o:block'
o.cindent = true
o.shiftwidth = 4
o.rtp:prepend(lazypath)

require('lazy').setup({
    'neovim/nvim-lspconfig',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-calc',
    'ibhagwan/fzf-lua',
    'nvim-tree/nvim-tree.lua',
    'nvim-tree/nvim-web-devicons',
    'catppuccin/nvim',
    'xiyaowong/transparent.nvim',
})

-- {{{ LSP
local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('lspconfig').clangd.setup {
    capabilities = capabilities,
    filetypes = { "c", "cpp" },
    root_dir = function()
	return vim.fn.getcwd()
    end
}
-- }}}

-- {{{ CMP
local cmp = require'cmp'

cmp.setup({
    completion = {
	autocomplete = false,
    },
    window = {
	-- completion = cmp.config.window.bordered(),
	-- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
	['<C-b>'] = cmp.mapping.scroll_docs(-4),
	['<C-f>'] = cmp.mapping.scroll_docs(4),
	['<C-Space>'] = cmp.mapping.complete(),
	['<C-e>'] = cmp.mapping.abort(),
	['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
	{ name = 'nvim_lsp' },
	{ name = 'calc' },
	{ name = 'buffer' },
	{ name = 'path' },
    })
})

-- }}}


-- {{{ NVIM-TREE
require("nvim-tree").setup({
    sort_by = "case_sensitive",
    view = {
	width = 50,
    },
    renderer = {
	group_empty = true,
    },
    filters = {
	dotfiles = true,
    },
})

--}}}

require("transparent")

vim.cmd.colorscheme 'catppuccin-frappe'
