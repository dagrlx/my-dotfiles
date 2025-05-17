return {
	"mason-org/mason.nvim",
	dependencies = {
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local mason = require("mason")
		local mason_tool_installer = require("mason-tool-installer")

		-- 🚀 Configuración de Mason
		mason.setup({
			ui = {
				border = "rounded",
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		-- 🔨 Instalación automática de herramientas adicionales
		mason_tool_installer.setup({
			ensure_installed = {
				"stylua",
				"black",
				"isort",
				"pylint",
				"eslint_d",
				"prettierd",
				"sql-formatter",
				"shellcheck",
				"yamllint",
				"beautysh",
			},
			automatic_installation = true,
		})
	end,
}
