local awful = require("awful")
local wibox = require("wibox")
local tagList = require("widgets.tag-list")
local layoutBox = require("widgets.layout-box")
local taskList = require("widgets.task-list")
local dpi = require('beautiful').xresources.apply_dpi

local TopPanel = function(s)
-- Create the wibo
    panel = awful.wibar({ position = "top", screen = s, height = dpi(24), })

	-- Add widgets to the wibox
	panel:setup {
	    layout = wibox.layout.align.horizontal,
	    { -- Left widgets
	        layout = wibox.layout.fixed.horizontal,
	        tagList(s),
	        layoutBox(s),
	        s.mypromptbox
	    },
	    nil, -- Middle widget
	    { -- Right widgets
	        layout = wibox.layout.fixed.horizontal,
	        wibox.widget.systray(),
	    },
	}
		

	return panel
end

return TopPanel