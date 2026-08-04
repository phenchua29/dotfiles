-- Hyprexpo plugin configuration.
-- The hyprexpo dispatcher is a plugin dispatcher accessed via hl.dsp.global().
hl.bind("SUPER + TAB", hl.dsp.global("hyprexpo:expo toggle"))

hl.config({
	plugin = {
		hyprexpo = {
			columns = 3,
			gap_size = 5,
			bg_col = "rgb(111111)",
			workspace_method = "center workspace",
		},
	},
})
