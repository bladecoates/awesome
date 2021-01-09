local awful = require("awful")
local wibox = require("wibox")
local theme = require("themes.default.theme")
local dpi = require('beautiful').xresources.apply_dpi

local SidePanel = function(s)

	local panel_content_width = dpi(12)
  panel.opened = false

    panel = wibox({
      screen = s,
      visible = true,
      ontop = false,
      stretch = false,
      width = panel_content_width,
      height = s.geometry.height - dpi(96),
      x = s.geometry.x,
      y = s.geometry.y + dpi(32),
      bg = theme.card_system_bg_normal
    })

    placeholder = wibox.widget {
      wibox.widget {
        text = "Placeholder",
        font = 'Montserrat-ExtraLight 8',
        widget = wibox.widget.textbox,
    },
    top = dpi(8),
    left = dpi(24),
    widget = wibox.container.margin
  }

  function panel.show(self)
      self.width = dpi(300)
      self.opened = true
      self:struts { left = dpi(308), right = 0, bottom = 0, top = 0 }
  end

  function panel.hide(self)
      self.width = panel_content_width
      self.opened = false
      self:struts { left = dpi(26), right = 0, bottom = 0, top = 0 }
  end

  function panel.toggle(self)
      if self.opened then
          self.hide(self)
      else
          self.show(self)
      end
  end

    panel:setup {
    	layout = wibox.layout.fixed.horizontal,
    	{
    		layout = wibox.layout.fixed.vertical,

		    {
          id = "panel_content",
		    	layout = wibox.layout.fixed.vertical,
		    	placeholder
		    },
		},
	    {
	    	{
	        valigh = 'center',
            layout = wibox.container.place
	        },
	    haligh = 'center',
	    spacing = dpi(32),
        layout = wibox.layout.align.horizontal
	    }
	}

	return panel
end

return SidePanel