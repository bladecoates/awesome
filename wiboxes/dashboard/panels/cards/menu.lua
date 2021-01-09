local awful = require("awful")
local wibox = require("wibox")
local dpi = require('beautiful').xresources.apply_dpi
local get_dpi = require('beautiful').xresources.get_dpi

local DashboardMenuCardPanel = function(s)

	local panel_content_width = dpi(6)
    local panel = wibox({
      screen = s,
      visible = true,
      ontop = false,
      stretch = false,
      width = panel_content_width,
      height = s.geometry.height - dpi(96),
      x = s.geometry.x,
      y = s.geometry.y + dpi(32),
    })

    panel.opened = false

  --   function panel:run_rofi()
  --   _G.awesome.spawn(
  --     'rofi -dpi ' .. get_dpi() .. ' -width ' .. dpi(300) .. ' -show drun -theme ' .. '~/.config/awesome/configuration/rofi.rasi -no-fixed-num-lines',
  --     false,
  --     false,
  --     false,
  --     false,
  --     function()
  --       panel:toggle()
  --     end
  --   )
  -- end

  function panel.show(self)
      self.width = dpi(300)
      self.opened = true
      awesome.spawn(
      'rofi -dpi ' .. get_dpi() .. ' -width ' .. dpi(300) .. ' -show drun -theme ' .. '~/.config/awesome/configuration/rofi.rasi -no-fixed-num-lines',
      false,
      false,
      false,
      false,
      function()
        --panel:hide(self)
      end
    )
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

		    nil,
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

return DashboardMenuCardPanel