-- ~/.config/nvim/lua/plugins/catppuccin.lua

return {
	"catppuccin/nvim",
	enabled = true,
	as = "catppuccin",
	config = function()
		require("catppuccin").setup({
			flavour = "mocha", -- O cualquier otro sabor que prefieras
			integrations = {
				blink_cmp = {
					style = "bordered",
				},
				treesitter = true,
				fzf = true,
				-- Agrega más integraciones si lo necesitas
			},
		})
		vim.cmd("colorscheme catppuccin-mocha")
	end,
}
