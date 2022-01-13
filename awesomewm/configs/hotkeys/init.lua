local gears = require("gears")
local awful = require("awful")
--local mainmenu = require("widgets.panel.menu").mainmenu
local globalkeys = require("configs.hotkeys.global")

root.keys(globalkeys)

root.buttons(gears.table.join(
 --       awful.button({ }, 3, function () mainmenu:toggle() end),
        awful.button({ }, 4, awful.tag.viewnext),
        awful.button({ }, 5, awful.tag.viewprev)
))

