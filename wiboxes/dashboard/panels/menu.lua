local awful = require("awful")
local wibox = require("wibox")
local dpi = require('beautiful').xresources.apply_dpi
local SidePanelMenu = require('widgets.dashboard-panel-menu')

local DashboardMenuPanel = function(s)

	local panel_content_width = dpi(6)
  panel.opened = false
    panel = wibox({
      screen = s,
      visible = true,
      ontop = false,
      stretch = false,
      type = "dock",
      width = panel_content_width,
      height = dpi(24),
      x = s.geometry.x,
      y = s.geometry.height - dpi(56),
    })

    placeholder = wibox.widget {
    	text = "holder",
        font = 'Montserrat-ExtraLight 8',
        widget = wibox.widget.textbox,
    }

  function panel.show(self)
      self.width = dpi(100)
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

    menus = SidePanelMenu(s)
    panel:setup {
    	layout = wibox.layout.align.horizontal,
      nil,
      nil,
        {
                 layout = wibox.layout.align.horizontal,
                 menus.menu,
              },
      }

	return panel
end

return DashboardMenuPanel