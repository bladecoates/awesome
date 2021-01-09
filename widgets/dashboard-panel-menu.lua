local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local theme = require("themes.default.theme")
local clickable_container = require('utils.clickable-container')
local dpi = require('beautiful').xresources.apply_dpi


local BuildDashboardPanelMenuButton = function(menu_name)
  local sidePanelMenuButton =
    wibox.widget {
        wibox.widget {
                wibox.widget {
                    wibox.widget {
                        text = menu_name,
                        widget = wibox.widget.textbox
                    },
                    top = dpi(4),
                    bottom = dpi(4),
                    left = dpi(4),
                    right = dpi(4),
                    widget = wibox.container.margin
                },
                widget = clickable_container
            },
          widget = wibox.container.place,
      }

  return sidePanelMenuButton
end

local DashboardPanelMenu = function(s)

  local menu = BuildDashboardPanelMenuButton('Menu')
    menu:connect_signal(
      'button::release',
      function()
          s.dashboard_menu_card_panel.toggle(s.dashboard_menu_card_panel)
          s.dashboard_system_card_panel.width = 12
          s.dashboard_info_card_panel.width = 18
          s.dashboard_menu_card_panel:struts { left = dpi(308), right = 0, bottom = 0, top = 0 }
      end
    )

  local system = BuildDashboardPanelMenuButton('System')
    system:connect_signal(
      'button::release',
      function()
          s.dashboard_system_card_panel.toggle(s.dashboard_system_card_panel)
          s.dashboard_menu_card_panel.width = 6
          s.dashboard_info_card_panel.width = 18
          s.dashboard_system_card_panel:struts { left = dpi(308), right = 0, bottom = 0, top = 0 }
      end
    )

  local info = BuildDashboardPanelMenuButton('Info')
    info:connect_signal(
      'button::release',
      function()
          s.dashboard_info_card_panel.toggle(s.dashboard_info_card_panel)

          s.dashboard_menu_card_panel.width = 6
          s.dashboard_system_card_panel.width = 12
          s.dashboard_info_card_panel:struts { left = dpi(308), right = 0, bottom = 0, top = 0 }
      end
    )


  return {
    menu = menu,
    system = system,
    info = info
  }
end

return DashboardPanelMenu