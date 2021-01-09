local awful = require("awful")
-- return {
--        "General",
--        "Queue",
--        "Terminal",
--        "Remote",
--        "Code",
--        "Comms",
--        "Misc" }
return {
            {
                name = "General",
                layout = awful.layout.suit.max,
            },
            {
                name = "Queue",
                layout = awful.layout.suit.max,
            },
            {
                name = "Terminal",
                layout = awful.layout.suit.tile,
            },
            {
                name = "Remote",
                layout = awful.layout.suit.max,
            },
            {
                name = "Code",
                layout = awful.layout.suit.max,
            },
            {
                name = "Comms",
                layout = awful.layout.suit.max,
            },
            {
                name = "Misc",
                layout = awful.layout.suit.max,
            }
}
