-- Hyprland background / wallpaper configuration.

local launchPrefix = "uwsm app --"

local forestPineTreeRain = "linux-wallpaperengine --screen-root eDP-2 2944854639"

-- linux-wallpaperengine --screen-root eDP-2 3016047975
-- mpvpaper eDP-2 6a41ab48117477.588f6a78d82a5_1.mp4 -o "no-audio --loop"

hl.on("hyprland.start", function()
	hl.exec_cmd(launchPrefix .. " waypaper --restore")
	-- hl.exec_cmd(launchPrefix .. " " .. forestPineTreeRain)
end)
