-- Unscale XWayland
hl.config({
	xwayland = {
		force_zero_scaling = true,
	},
})

-- Toolkit-specific scale
hl.env("GDK_SCALE", "1")
hl.env("XCURSOR_SIZE", "24")
