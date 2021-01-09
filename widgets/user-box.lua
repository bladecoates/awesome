local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local theme = require("themes.default.theme")
local clickable_container = require('utils.clickable-container')
local dpi = require('beautiful').xresources.apply_dpi


local UserBox = function(s)

  local user = wibox.widget {
                   wibox.widget {
                      text = os.getenv("USER"),
                      font = 'Montserrat-ExtraLight 8',
                      widget = wibox.widget.textbox,
                    },
                    left = dpi(4),
                    right = dpi(4),
                    widget = wibox.container.margin
                  }

  user:buttons(
    awful.util.table.join(
      awful.button(
        {},
        1,
        function()
          _G.exit_screen_show()
        end
      )
    )
  )

  usercontainer = wibox.container.margin(user, 0, 0, 5, 5)
  userbox = clickable_container(usercontainer, theme.bg_normal, gears.shape.rectangle)
  return userbox
end

return UserBox