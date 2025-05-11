return {
	"neovim/nvim-lspconfig",
	event = "BufReadPost",
	dependencies = {
		{ "mason-org/mason.nvim" },
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local lspconfig = require("lspconfig")
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
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

		-- Capabilities Globales (autocomplete, etc.)
		-- Add the same capabilities to ALL server configurations.
		-- Refer to :h vim.lsp.config() for more information.
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		vim.lsp.config("*", { capabilities = capabilities })

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
				"ansiblels", -- Ansible
				"ts_ls", -- JavaScript
				"html", -- HTML
				"cssls", -- CSS
				"lua_ls", -- Lua
				"pyright", -- Python
				"jsonls", -- JSON
				"yamlls", -- YAML
				"marksman", -- Markdown
				"docker_compose_language_service", -- Docker
				"dockerls", -- Dockerfile
				"bashls", -- Bash
				"sqls", -- SQL
				"taplo", -- Toml
				-- "nil_ls", -- nix
				"rust_analyzer", -- Rust
			},
			-- automatic_installation = true,
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

		-- Config específica para Lua
		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					runtime = { version = "LuaJIT" },
					diagnostics = { globals = { "vim" } },
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
						checkThirdParty = false,
					},
					telemetry = { enable = false },
				},
			},
		})
	end,
}
