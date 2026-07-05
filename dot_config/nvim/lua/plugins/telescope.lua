return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		keys = {
			{ "<leader>p", "<cmd>silent Telescope commands<CR>", desc = "Telescope commands" },
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-fzf-native.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
		},
		opts = function()
			return {
				defaults = {
					prompt_prefix = "🔍",
					results_title = "🍀",
					path_display = { "filename_first" },
					dynamic_preview_title = true,
					layout_strategy = "horizontal",
					sorting_strategy = "ascending",
					layout_config = {
						horizontal = {
							prompt_position = "top",
							preview_width = 0.5,
						},
						center = {
							preview_cutoff = 1,
						},
					},
					file_ignore_patterns = {
						"%.obsidian/",
					},
				},
				pickers = {
					find_files = {
						file_ignore_patterns = {
							"^node_modules",
							"^.git",
							"^.venv",
							"^.next",
							"^.history",
							"^android",
							"^build",
							"%.obsidian/",
						},
						hidden = true,
						no_ignore = true,
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			}
		end,
		config = function(_, opts)
			local telescope = require("telescope")
			telescope.setup(opts)
			telescope.load_extension("ui-select")

			vim.api.nvim_set_hl(0, "TelescopeNormal", {})
			vim.api.nvim_set_hl(0, "TelescopeBorder", {})
		end,
	},
}
