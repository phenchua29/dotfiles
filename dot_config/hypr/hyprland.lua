-- Hyprland Lua configuration entry point.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

require("background")
require("programs")
require("monitors")
require("appearance")
require("env")
require("input")
require("keybinds")
require("window-rules")
require("xwayland-fix")
-- require("debug") -- Just for debugging

-- >>> jcode launch hotkeys (managed) >>>
-- jcode: home
hl.bind("SUPER + semicolon", hl.dsp.exec_cmd("/home/phenchua/.jcode/hotkey/launch_jcode_0_cmd_semicolon.sh"))
-- jcode: last project
hl.bind("SUPER + apostrophe", hl.dsp.exec_cmd("/home/phenchua/.jcode/hotkey/launch_jcode_1_cmd_quote.sh"))
-- jcode: self-dev
hl.bind("SUPER SHIFT + apostrophe", hl.dsp.exec_cmd("/home/phenchua/.jcode/hotkey/launch_jcode_2_cmd_shift_quote.sh"))
-- <<< jcode launch hotkeys (managed) <<<
