local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()

config.default_prog = {'c:\\tools\\msys64\\usr\\bin\\zsh.exe', "--login"}

config.font = wezterm.font("Iosevka NFM")
-- config.font.font_antialias = "Subpixel" -- None, Greyscale, Subpixel
config.font_size = 9
config.color_scheme = 'catppuccin-mocha'

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true


local function get_files_in_dir(dir)
    local cmd = 'dir "' .. dir .. '" /b /s'
    local pfile = io.popen(cmd)

    local i = 0
    local filenames = {}

    for filename in pfile:lines() do
       filenames[i] = filename 
       i = i + 1
    end
    pfile:close()
    return filenames
end

local function get_random_wallpaper()
    local filenames = get_files_in_dir('d:\\tmp\\wallpapers\\')
    local filename = filenames[math.random(#filenames)]
    return filename
end


wezterm.on("window-config-reloaded", function(window, pane)
    local wallpaper = get_random_wallpaper()
    local overrides = window:get_config_overrides{} or {}
    overrides.window_background_image = wallpaper
    window:set_config_overrides(overrides)
end)

-- config.window_background_image = 'd:\\tmp\\wallpapers\\macro-plants-flowers-nature-wallpaper.jpg'
-- config.window_background_image = 'd:\\tmp\\wallpapers\\pexels-stywo-1054218.jpg'
-- config.window_background_image = 'd:\\tmp\\wallpapers\\drew-taylor-7yty0M7XnYU-unsplash.jpg'

config.window_background_image_hsb = {
	brightness = 0.1,
}


config.command_palette_font_size = 10
-- config.status_update_interval = 100


wezterm.on('update-right-status', function(window, pane)
  local name = window:active_key_table()
  if name then
    name = 'TABLE: ' .. name
  else 
  	name = ''
  end

  local leader = ''
  if window:leader_is_active() then
    -- leader = 'LEADER'
    leader = utf8.char(127754)
  end

  window:set_left_status(leader)
  window:set_right_status(name)
end)





config.leader = { key = 'b', mods = 'CTRL' }


config.keys = {
    { key = 'p', mods = 'CTRL', action = wezterm.action.ActivateCommandPalette},

    { key = ' ', mods = 'CTRL|SHIFT', action = wezterm.action.DisableDefaultAssignment },
    { key = 'Space', mods = 'CTRL|SHIFT', action = wezterm.action.DisableDefaultAssignment },
    { key = 'Space', mods = 'CTRL|SHIFT', action = wezterm.action.ActivateCopyMode },

    { key = "c", mods = "LEADER",       action=wezterm.action{SpawnTab="CurrentPaneDomain"}},
    { key = "%", mods = "LEADER|SHIFT", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
    { key = "\"", mods = "LEADER|SHIFT", action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},

    { key = "n", mods = "LEADER", action = wezterm.action.ActivateTabRelative(1)},
    { key = "p", mods = "LEADER", action = wezterm.action.ActivateTabRelative(-1)},
    

    {
      key = ',',
      mods = 'LEADER',
      action = wezterm.action.PromptInputLine {
        description = 'Enter new name for tab',
        action = wezterm.action_callback(function(window, pane, line)
          -- line will be `nil` if they hit escape without entering anything
          -- An empty string if they just hit enter
          -- Or the actual line of text they wrote
          if line then
            window:active_tab():set_title(line)
          end
        end),
      },
    },

    -- { key = "n", mods = "LEADER", action=wezterm.action.}


    -- { key = "-", mods = "LEADER",       action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
    
    -- { key = "s", mods = "LEADER",       action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
    

    -- { key = "a", mods = "LEADER|CTRL",  action=wezterm.action{SendString="\x01"}},
    
    -- { key = "o", mods = "LEADER",       action="TogglePaneZoomState" },
    -- { key = "z", mods = "LEADER",       action="TogglePaneZoomState" },
    { key = "h", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Left"}},
    { key = "j", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Down"}},
    { key = "k", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Up"}},
    { key = "l", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Right"}},

    { key = "LeftArrow", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Left"}},
    { key = "DownArrow", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Down"}},
    { key = "UpArrow", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Up"}},
    { key = "RightArrow", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Right"}},
	
    { key = "H", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Left", 5}}},
    { key = "J", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Down", 5}}},
    { key = "K", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Up", 5}}},
    { key = "L", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Right", 5}}},

    { key = "1", mods = "LEADER",       action=wezterm.action{ActivateTab=0}},
    { key = "2", mods = "LEADER",       action=wezterm.action{ActivateTab=1}},
    { key = "3", mods = "LEADER",       action=wezterm.action{ActivateTab=2}},
    { key = "4", mods = "LEADER",       action=wezterm.action{ActivateTab=3}},
    { key = "5", mods = "LEADER",       action=wezterm.action{ActivateTab=4}},
    { key = "6", mods = "LEADER",       action=wezterm.action{ActivateTab=5}},
    { key = "7", mods = "LEADER",       action=wezterm.action{ActivateTab=6}},
    { key = "8", mods = "LEADER",       action=wezterm.action{ActivateTab=7}},
    { key = "9", mods = "LEADER",       action=wezterm.action{ActivateTab=8}},
    { key = "&", mods = "LEADER|SHIFT", action=wezterm.action{CloseCurrentTab={confirm=true}}},
    { key = "d", mods = "LEADER",       action=wezterm.action{CloseCurrentPane={confirm=true}}},
    { key = "x", mods = "LEADER",       action=wezterm.action{CloseCurrentPane={confirm=true}}},
}





return config
