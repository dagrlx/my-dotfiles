return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		{ "mason-org/mason-lspconfig.nvim" },
		{ "folke/lazydev.nvim", opts = {} },
	},
	config = function()
		-- local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")

		-- Capabilities Globales (autocomplete, etc.)
		-- Add the same capabilities to ALL server configurations.
		-- Refer to :h vim.lsp.config() for more information.
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		vim.lsp.config("*", { capabilities = capabilities })

		-- Configuración de Mason-LSPConfig
		mason_lspconfig.setup({
			ensure_installed = {
				"ansiblels", -- Ansible
				"ts_ls", -- TypeScript
				"html", -- HTML
				"cssls", -- CSS
				"lua_ls",
				--"emmylua_ls", -- Lua
				--"pyright", -- Python
				"jedi_language_server", -- Python
				"ruff", -- Python
				"jsonls", -- JSON
				"marksman", -- Markdown
				"docker_compose_language_service", -- Docker Compose
				"dockerls", -- Docker
				"bashls", -- Bash
				"sqls", -- SQL
				"taplo", -- TOML
				"rust_analyzer", -- Rust
			},
			automatic_enable = true, -- Habilita automáticamente servidores instalados
		})

		-- Configuración específica para lua_ls
		vim.lsp.config("lua_ls", {
			capabilities = capabilities,
			settings = {
				Lua = {
					runtime = { version = "LuaJIT" },
					diagnostics = {
						globals = { "vim", "mp" },
						disable = { "missing-fields" },
					},
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
						checkThirdParty = false,
					},
					-- telemetry = { enable = false },
				},
			},
		})

		-- Configuración específica para ruff
		vim.lsp.config("ruff", {
			capabilities = capabilities,
			init_options = {
				settings = {
					logLevel = "info",
				},
			},
		})

		-- Configuración de diagnósticos globales
		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.HINT] = "",
					[vim.diagnostic.severity.INFO] = "",
				},
				numhl = {
					[vim.diagnostic.severity.ERROR] = "ErrorMsg",
					[vim.diagnostic.severity.WARN] = "WarningMsg",
				},
			},
			virtual_text = false,
			underline = true,
			update_in_insert = false,
			severity_sort = true,
			float = {
				border = "rounded",
				source = true,
			},
		})
	end,
}
