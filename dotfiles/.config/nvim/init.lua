--disable plugins
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
--

require("config.lazy")
vim.cmd("colorscheme catppuccin-frappe")

--options
local o = vim.opt
o.tabstop = 4
o.shiftwidth = 4
o.autoindent = true
o.number = true
o.relativenumber = true
o.wrap = false

local map = vim.api.nvim_set_keymap
