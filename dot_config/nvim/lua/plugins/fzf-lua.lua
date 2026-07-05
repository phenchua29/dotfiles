return {
	{
		"ibhagwan/fzf-lua",
		cmd = "FzfLua",
		keys = {
			{ "<leader>f", "<cmd>silent FzfLua files<CR>", desc = "Find files" },
			{ "<leader>s", "<cmd>silent FzfLua live_grep<CR>", desc = "Live grep" },
			{ "<leader>u", "<cmd>silent FzfLua grep_cword<CR>", desc = "Grep word under cursor" },
		},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			files = {
				hidden = true,
				fd_opts = "--type f "
					.. "--type l "
					.. "--hidden "
					.. "-E .git "
					.. "-E nbproject "
					.. "-E node_modules "
					.. "-E .venv "
					.. "-E .next "
					.. "-E .history "
					.. "-E android "
					.. "-E .obsidian",
			},
			grep = {
				rg_blob = true,
				rg_opts = "--column "
					.. "--line-number "
					.. "--no-heading "
					.. "--color=always "
					.. "--smart-case "
					.. "--max-columns=4096 "
					.. "--glob '!.git/*' "
					.. "--glob '!nbproject/*' "
					.. "--glob '!node_modules/*' "
					.. "--glob '!.venv/*' "
					.. "--glob '!.next/*' "
					.. "--glob '!.history/*' "
					.. "--glob '!android/*' "
					.. "--glob '!.obsidian/*' "
					.. "-e",
			},
		},
	},
}
