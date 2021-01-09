local awful = require('awful')
local gears = require('gears')
local wibox = require('wibox')
local beautiful = require('beautiful')
local icons = require('themes.default.icons')
local clickable_container = require('utils.clickable-container')
local dpi = require('beautiful').xresources.apply_dpi

-- Appearance
local icon_size = beautiful.exit_screen_icon_size or dpi(32)

local action = wibox.widget {
    text = ' ',
    widget = wibox.widget.textbox
}

local buildButton = function(icon, action_name)
  local abutton =
    wibox.widget {
    wibox.widget {
      wibox.widget {
        wibox.widget {
          image = icon,
          widget = wibox.widget.imagebox
        },
        top = dpi(4),
        bottom = dpi(4),
        left = dpi(4),
        right = dpi(4),
        widget = wibox.container.margin
      },
      shape = gears.shape.circle,
      forced_width = icon_size,
      forced_height = icon_size,
      widget = clickable_container
    },
    left = dpi(4),
    right = dpi(4),
    widget = wibox.container.margin
  }

  abutton:connect_signal("mouse::enter", function() action:set_text(action_name) end)
  abutton:connect_signal("mouse::leave", function() action:set_text(' ') end)

  return abutton
end

function suspend_command()
  exit_screen_hide()
  awful.spawn.with_shell('/usr/bin/dm-tool lock && systemctl suspend')
end
function exit_command()
  _G.awesome.quit()
end
function lock_command()
  exit_screen_hide()
  awful.spawn.with_shell('/usr/bin/dm-tool lock')
end
function poweroff_command()
  awful.spawn.with_shell('systemctl poweroff')
  awful.keygrabber.stop(_G.exit_screen_grabber)
end
function reboot_command()
  awful.spawn.with_shell('systemctl reboot')
  awful.keygrabber.stop(_G.exit_screen_grabber)
end
function switch_command()
  awful.spawn.with_shell('/usr/bin/dm-tool switch-to-greeter')
  awful.keygrabber.stop(_G.exit_screen_grabber)
end

local switch = buildButton(icons.switch, 'Switch Users')
switch:connect_signal(
  'button::release',
  function()
    switch_command()
  end
)

local poweroff = buildButton(icons.power, 'Shutdown')
poweroff:connect_signal(
  'button::release',
  function()
    poweroff_command()
  end
)

local reboot = buildButton(icons.restart, 'Restart')
reboot:connect_signal(
  'button::release',
  function()
    reboot_command()
  end
)

local suspend = buildButton(icons.sleep, 'Sleep')
suspend:connect_signal(
  'button::release',
  function()
    suspend_command()
  end
)

local exit = buildButton(icons.logout, 'Logout')
exit:connect_signal(
  'button::release',
  function()
    exit_command()
  end
)

local lock = buildButton(icons.lock, 'Lock')
lock:connect_signal(
  'button::release',
  function()
    lock_command()
  end
)

-- Get screen geometry
local screen_geometry = awful.screen.focused().geometry

-- Create the widget
exit_screen =
  wibox(
  {
    x = screen_geometry.x,
    y = screen_geometry.y,
    visible = false,
    ontop = true,
    type = 'splash',
    height = dpi(200),
    width = dpi(400)
  }
)

exit_screen.bg = '#353c44dd'
exit_screen.fg = '#FEFEFE'

local exit_screen_grabber

function exit_screen_hide()
  awful.keygrabber.stop(exit_screen_grabber)
  exit_screen.visible = false
end

function exit_screen_show()
  -- naughty.notify({text = "starting the keygrabber"})
  exit_screen_grabber =
    awful.keygrabber.run(
    function(_, key, event)
      if event == 'release' then
        return
      end

      if key == 's' then
        suspend_command()
      elseif key == 'e' then
        exit_command()
      elseif key == 'l' then
        lock_command()
      elseif key == 'p' then
        poweroff_command()
      elseif key == 'r' then
        reboot_command()
      elseif key == 'u' then
        switch_command()
      elseif key == 'Escape' or key == 'q' or key == 'x' then
        -- naughty.notify({text = "Cancel"})
        exit_screen_hide()
      -- else awful.keygrabber.stop(exit_screen_grabber)
      end
    end
  )
  exit_screen.visible = true
end

exit_screen:buttons(
  gears.table.join(
    -- Middle click - Hide exit_screen
    awful.button(
      {},
      2,
      function()
        exit_screen_hide()
      end
    ),
    -- Right click - Hide exit_screen
    awful.button(
      {},
      3,
      function()
        exit_screen_hide()
      end
    )
  )
)

-- Item placement
exit_screen:setup {
  nil,
  {
    nil,
    {
      {
        -- {
        poweroff,
        reboot,
        suspend,
        exit,
        lock,
        switch,
        layout = wibox.layout.fixed.horizontal,
        spacing = dpi(8),
        -- },
        -- widget = exit_screen_box
      },
      valigh = 'center',
      layout = wibox.container.place
    },
    {
      action,
      haligh = 'center',
      layout = wibox.container.place
    },
    spacing = dpi(32),
    layout = wibox.layout.align.vertical
  },
  nil,
  expand = 'none',
  valigh = 'center',
  layout = wibox.container.place
}

awful.placement.centered(exit_screen)
