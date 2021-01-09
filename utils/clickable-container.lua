local wibox = require('wibox')

function build(widget)
  local container =
    wibox.widget {
    widget,
    widget = wibox.container.background,
  }
  local old_cursor, old_wibox

  container:connect_signal(
    'mouse::enter',
    function()
      container.bg = '#57626f'
      container.fg = '#FFFFFF'
      local w = _G.mouse.current_wibox
      if w then
        old_cursor, old_wibox = w.cursor, w
        w.cursor = 'hand1'
      end
    end
  )

  container:connect_signal(
    'mouse::leave',
    function()
      container.bg = '#ffffff00'
      container.fg = '#aaaaaa'
      if old_wibox then
        old_wibox.cursor = old_cursor
        old_wibox = nil
      end
    end
  )

  container:connect_signal(
    'button::press',
    function()
      container.bg = '#57626f'
      container.fg = '#FFFFFF'
    end
  )

  container:connect_signal(
    'button::release',
    function()
      container.bg = '#ffffff00'
      container.fg = '#aaaaaa'
    end
  )

  return container
end

return build
