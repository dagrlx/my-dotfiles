-------------------------------------------------
-- name : nvim-treesitter
-- url  : https://github.com/nvim-treesitter/nvim-treesitter
return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{
			"nvim-treesitter/nvim-treesitter-context",
			opts = {
				enable = true,
				max_lines = 3,
				multiline_threshold = 1,
				min_window_height = 20,
			},
			keys = {
				--{ "<leader>uC", ":TSContextToggle<CR>", desc = "Toggle TSContext" },
				{
					"<leader>uC",
					function()
						require("treesitter-context").toggle()
					end,
					desc = "Toggle TSContext",
				},

				{
					"[c",
					":lua require('treesitter-context').go_to_context()<cr>",
					silent = true,
					desc = "Go to context",
				},
			},
		},
		"bezhermoso/tree-sitter-ghostty",
	},
	opts = {
		ensure_installed = {
			"bash",
			"diff",
			"lua",
			"luadoc",
			"javascript",
			"typescript",
			"json",
			"python",
			"html",
			"css",
			"csv",
			"dockerfile",
			"dot",
			"ghostty",
			"git_config",
			"gitignore",
			"gitcommit",
			"markdown",
			"markdown_inline",
			"nu",
			"nix",
			"passwd",
			"php",
			"query",
			"sql",
			"ssh_config",
			"tmux",
			"toml",
			"terraform",
			"vim",
			"vimdoc",
			"yaml",
			"rust",
			"regex",
		},
		-- Install parsers synchronously (only applied to `ensure_installed`)
		sync_install = false,

		-- Automatically install missing parsers when entering buffer
		-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
		auto_install = true,

		highlight = { enable = true, additional_vim_regex_highlighting = false },
		indent = { enable = true },
	},
}
