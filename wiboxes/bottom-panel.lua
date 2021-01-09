local awful = require("awful")
local wibox = require("wibox")
local taskList = require("widgets.task-list")
local userBox = require("widgets.user-box")
local sideMenuBox = require("widgets.menu-button")
local theme = require("themes.default.theme")
local dpi = require('beautiful').xresources.apply_dpi


local BottomPanel = function(s)
    panel = awful.wibar({ position = "bottom", screen = s, height = dpi(24) })

    user_icon = wibox.widget.imagebox(theme.user_icon)
    spr_small = wibox.widget.imagebox(theme.spr_small)

	panel:setup {
	    layout = wibox.layout.align.horizontal,
	    {
	        layout = wibox.layout.fixed.horizontal,
	        sideMenuBox(s),
	        spr_small,
	        user_icon,
	        userBox(s),
	        spr_small,
	        mylauncher,
	    },
	    taskList(s),
	    {
	        layout = wibox.layout.fixed.horizontal,
	        mytextclock,
	    },
	}

	return panel
end

return BottomPanel