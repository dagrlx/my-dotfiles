return {
	"neovim/nvim-lspconfig",
	event = "BufReadPost",
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
