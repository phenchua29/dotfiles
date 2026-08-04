-- Hyprland input configuration.
-- https://wiki.hypr.land/Configuring/Basics/Variables/#input

hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_options = "",
		kb_rules = "",

		follow_mouse = 1,

		sensitivity = 0, -- -1.0 to 1.0, 0 means no modification.

		touchpad = {
			natural_scroll = false,
			-- workspace_swipe removed in Hyprland v0.55
		},
	},
	-- gestures section removed in Hyprland v0.55; workspace_swipe is now at input.touchpad.workspace_swipe
})

-- Example per-device config.
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
	name = "epic-mouse-v1",
	sensitivity = -0.5,
})
