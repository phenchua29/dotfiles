-- Hyprland window and workspace rules.
-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/ for more
-- See https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/ for workspace rules

-- Ignore maximize requests from apps. You'll probably like this.
hl.window_rule({
	match = { class = ".*" },
	suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland.
hl.window_rule({
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		fullscreen = false,
	},
	no_focus = true,
})

-- Make all windows float.
-- hl.window_rule({ match = { class = ".*" }, float = true })

-- Resize floating windows.
hl.window_rule({ match = { class = "firefox" }, size = "1080 650" })
hl.window_rule({ match = { initial_title = "zalo" }, size = "1080 650" })
