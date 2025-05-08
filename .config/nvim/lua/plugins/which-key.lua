-- ~/.config/nvim/lua/plugins/nvim-notify.lua

return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 500
	end,
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		-- delay = 1000,
	},
	dependencies = {
		"echasnovski/mini.icons",
	},
}
