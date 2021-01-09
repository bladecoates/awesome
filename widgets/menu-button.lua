local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local theme = require("themes.default.theme")
local clickable_container = require('utils.clickable-container')
local dpi = require('beautiful').xresources.apply_dpi


local SideMenuButton = function(s)

  local menu = wibox.widget {
      image = theme.side_menu_icon,
      size = dpi(32),
      widget = wibox.widget.imagebox,
      }

  menu:buttons(
    awful.util.table.join(
      awful.button(
        {},
        1,
        function()
            s.dashboard_menu_card_panel.toggle(s.dashboard_menu_card_panel)
            s.dashboard_menu_panel.toggle(s.dashboard_menu_panel)
            s.dashboard_system_panel.toggle(s.dashboard_system_panel)
            s.dashboard_info_panel.toggle(s.dashboard_info_panel)
        end
      )
    )
  )

  -- menu:connect_signal(
  --   'mouse::enter',
  --   function()
  --      if s.dashboard_menu_card_panel.width == dpi(6) then
  --         s.dashboard_menu_card_panel.toggle(s.dashboard_menu_card_panel)
  --           s.dashboard_menu_panel.width = dpi(100)
  --           s.dashboard_menu_card_panel.width = dpi(300)
  --           s.dashboard_system_panel.width = dpi(200)
  --           s.dashboard_info_panel.width = dpi(300)
  --           s.dashboard_menu_panel:struts { left = dpi(308), right = 0, bottom = 0, top = 0 }
  --         else
  --           s.dashboard_menu_panel.width = dpi(6)
  --           s.dashboard_menu_card_panel.width = dpi(6)
  --           s.dashboard_system_panel.width = dpi(12)
  --           s.dashboard_info_panel.width = dpi(18)
  --           s.dashboard_menu_panel:struts { left = dpi(26), right = 0, bottom = 0, top = 0 }
  --         end
  --   end
  -- )

  -- )

  menucontainer = wibox.container.margin(menu, 0, 0, 5, 5)
  menubox = clickable_container(menucontainer, theme.bg_normal, gears.shape.rectangle)
  return menubox
end

return SideMenuButton