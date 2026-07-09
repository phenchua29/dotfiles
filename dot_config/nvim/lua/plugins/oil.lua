return {
	{
		"stevearc/oil.nvim",
		lazy = false,
		keys = {
			{ "<leader>e", "<cmd>Oil<CR>", desc = "Open explorer" },
		},
		opts = {
			view_options = {
				show_hidden = true,
			},
			watch_for_changes = true,
		},
	},
}
