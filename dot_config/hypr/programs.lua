-- Hyprland program definitions and autostart.
-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Set programs that you use.
local launchPrefix = "uwsm app --"

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
hl.on("hyprland.start", function()
	hl.exec_cmd("~/.config/hypr/fix-xdg-desktop-portal.sh")
	-- hl.exec_cmd(launchPrefix .. " " .. terminal)
	-- hl.exec_cmd(launchPrefix .. " waybar")
	hl.exec_cmd('bash -c "wayle panel start && sleep 2 && wayle panel hide"')
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
	-- hl.exec_cmd(launchPrefix .. " nm-applet")
	hl.exec_cmd(launchPrefix .. " hyprpm reload -n")
	hl.exec_cmd(launchPrefix .. " fcitx5")
	-- hl.exec_cmd(launchPrefix .. " blueman-applet")
	hl.exec_cmd(launchPrefix .. " vicinae server")
end)
