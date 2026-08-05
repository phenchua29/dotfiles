-- Hyprland keybindings.
-- See https://wiki.hypr.land/Configuring/Basics/Binds/ for more

local mainMod = "SUPER"
local launchPrefix = "uwsm app --"
local terminal = "kitty"
local fileManager = "dolphin"

-- Basic window management
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind("ALT + M", hl.dsp.window.kill())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind("ALT + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + V", hl.dsp.window.float())
-- hl.bind(mainMod .. " + P", hl.dsp.exit())
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo()) -- dwindle

-- Move focus with mainMod + hjkl
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with ALT + [QWEASD]
hl.bind("ALT + Q", hl.dsp.focus({ workspace = "1" }))
hl.bind("ALT + W", hl.dsp.focus({ workspace = "2" }))
hl.bind("ALT + E", hl.dsp.focus({ workspace = "3" }))
hl.bind("ALT + A", hl.dsp.focus({ workspace = "4" }))
hl.bind("ALT + S", hl.dsp.focus({ workspace = "5" }))
hl.bind("ALT + D", hl.dsp.focus({ workspace = "6" }))
hl.bind(mainMod .. " + 7", hl.dsp.focus({ workspace = "7" }))
hl.bind(mainMod .. " + 8", hl.dsp.focus({ workspace = "8" }))
hl.bind(mainMod .. " + 9", hl.dsp.focus({ workspace = "9" }))
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = "10" }))

-- Move active window to a workspace (silent = no follow = stay on current workspace)
hl.bind("ALT + SHIFT + Q", hl.dsp.window.move({ workspace = "1", follow = false }))
hl.bind("ALT + SHIFT + W", hl.dsp.window.move({ workspace = "2", follow = false }))
hl.bind("ALT + SHIFT + E", hl.dsp.window.move({ workspace = "3", follow = false }))
hl.bind("ALT + SHIFT + A", hl.dsp.window.move({ workspace = "4", follow = false }))
hl.bind("ALT + SHIFT + S", hl.dsp.window.move({ workspace = "5", follow = false }))
hl.bind("ALT + SHIFT + D", hl.dsp.window.move({ workspace = "6", follow = false }))
hl.bind(mainMod .. " + SHIFT + 7", hl.dsp.window.move({ workspace = "7", follow = false }))
hl.bind(mainMod .. " + SHIFT + 8", hl.dsp.window.move({ workspace = "8", follow = false }))
hl.bind(mainMod .. " + SHIFT + 9", hl.dsp.window.move({ workspace = "9", follow = false }))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = "10", follow = false }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag())
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize())

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 10%+"), { repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"), { repeating = true })
hl.bind("ALT + Prior", hl.dsp.dpms({ action = "on" }), { repeating = true })
hl.bind("ALT + Next", hl.dsp.dpms({ action = "off" }), { repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Custom bindings
hl.bind("ALT + SPACE", hl.dsp.exec_cmd(launchPrefix .. " rofi -show drun"))
hl.bind("ALT + P", hl.dsp.exec_cmd(launchPrefix .. " vicinae toggle"))
hl.bind("ALT + T", hl.dsp.exec_cmd(launchPrefix .. " rofi -show window"))
hl.bind("ALT + SHIFT + R", hl.dsp.exec_cmd("killall waybar && " .. launchPrefix .. " waybar"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd(launchPrefix .. " grimblast copy area"))

hl.bind("ALT + SHIFT + L", hl.dsp.exec_cmd("kitty -e $HOME/fpt/codes/caro-universe-v2/run.sh"))
-- hl.bind("SUPER + B", hl.dsp.exec_cmd("killall -SIGUSR1 waybar"))
hl.bind("SUPER + B", hl.dsp.exec_cmd("wayle panel toggle"))
hl.bind("End", hl.dsp.exec_cmd(launchPrefix .. " pkill -USR2 -x handy"))
