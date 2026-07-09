return {
	"terrastruct/d2-vim",
	ft = "d2",
	init = function()
		-- Validation
		vim.g.d2_validate_autosave = 1

		-- Preview
		vim.g.d2_play_theme = 300
		vim.g.d2_play_sketch = 1
	end,
}
