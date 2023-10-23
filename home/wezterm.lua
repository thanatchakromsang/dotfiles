local wezterm = require("wezterm")

local config = {}
local act = wezterm.action

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.adjust_window_size_when_changing_font_size = false
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.color_scheme = "Gruvbox dark, medium (base16)"

config.default_prog = { "powershell", "-c", "wsl", "--cd ~" }
-- config.default_domain = "WSL:NixOS"

config.colors = {
	compose_cursor = "orange",
}

config.audible_bell = "Disabled"

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 }

config.keys = {
	{
		key = "v",
		mods = "LEADER",
		action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "b",
		mods = "LEADER",
		action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "c",
		mods = "LEADER",
		action = act.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "x",
		mods = "LEADER",
		action = act.CloseCurrentPane({ confirm = true }),
	},
	-- Arrow Key Movement
	{
		key = "LeftArrow",
		mods = "SHIFT|CTRL",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "RightArrow",
		mods = "SHIFT|CTRL",
		action = act.ActivatePaneDirection("Right"),
	},
	{
		key = "UpArrow",
		mods = "SHIFT|CTRL",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "DownArrow",
		mods = "SHIFT|CTRL",
		action = act.ActivatePaneDirection("Down"),
	},
	-- HJKL Movement
	{
		key = "H",
		mods = "SHIFT|CTRL",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "L",
		mods = "SHIFT|CTRL",
		action = act.ActivatePaneDirection("Right"),
	},
	{
		key = "K",
		mods = "SHIFT|CTRL",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "J",
		mods = "SHIFT|CTRL",
		action = act.ActivatePaneDirection("Down"),
	},
	-- Tab/S-Tab
	{
		key = "Tab",
		mods = "SHIFT|LEADER",
		action = act.ActivateTabRelative(-1),
	},
	{
		key = "Tab",
		mods = "LEADER",
		action = act.ActivateTabRelative(1),
	},
	-- Rename Active Tab
	{
		key = ",",
		mods = "LEADER",
		action = act.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, _, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
}

for i = 1, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = act.ActivateTab(i - 1),
	})
end

return config
