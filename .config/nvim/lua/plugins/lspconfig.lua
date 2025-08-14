return {
	"neovim/nvim-lspconfig",
	event = "BufReadPre",
	dependencies = {
		{ "mason-org/mason.nvim" },
		"mason-org/mason-lspconfig.nvim",
	},
	config = function()
		local lspconfig = require("lspconfig")
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")

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
				--"emmylua_ls", -- Lua
				--"pyright", -- Python
				"ruff", -- Python
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
		})

		require("lazydev").setup()

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

		vim.lsp.config("ruff", {
			init_options = {
				settings = {
					logLevel = "info",
				},
			},
		})

		vim.lsp.enable({ "lua_ls", "ruff" })

		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.HINT] = "",
					[vim.diagnostic.severity.INFO] = "",
				},
			},
			virtual_text = false, -- ✅ desactiva los mensajes inline
			underline = true,
			update_in_insert = false,
			severity_sort = true,
			float = {
				border = "rounded",
				source = "always",
			},
		})
	end,
}
