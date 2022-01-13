local gears = require("gears")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local apps = require("configs.apps")

local modkey    = "Mod4"
local ctrlkey   = "Control"
local shiftkey  = "Shift"

local globalkeys = gears.table.join(
        -- Standard program
        awful.key({ modkey,           }, "Return", function () awful.spawn(apps.terminal) end,          {description = "Открыть терминал",                  group = "launcher"}),
        awful.key({ modkey, ctrlkey   }, "r", awesome.restart,                                          {description = "Перезапустить awesome",             group = "awesome"}),
        awful.key({ modkey, shiftkey  }, "q", awesome.quit,                                             {description = "Завершить сессию",                  group = "awesome"}),

        awful.key({ modkey,           }, "/",      hotkeys_popup.show_help,                             {description = "Плашка с hotkey'ми",                group="awesome"}),
        awful.key({ modkey,           }, "s",      function() awful.spawn(apps.rofi_search) end,        {description = "Плашка с hotkey'ми",                group="awesome"}),
        awful.key({ modkey,           }, "Left",   awful.tag.viewprev,                                  {description = "view previous",                     group = "tag"}),
        awful.key({ modkey,           }, "Right",  awful.tag.viewnext,                                  {description = "view next",                         group = "tag"}),

        -- Управление слоями и клиентами
        awful.key({ modkey,           }, "j", function() awful.client.focus.bydirection("down")  end,   {description = "Фокус на нижнее окно",              group = "client"}),
        awful.key({ modkey,           }, "h", function() awful.client.focus.bydirection("left")  end,   {description = "Фокус на левое окно",               group = "client"}),
        awful.key({ modkey,           }, "l", function() awful.client.focus.bydirection("right") end,   {description = "Фокус на правое окно",              group = "client"}),
        awful.key({ modkey,           }, "k", function() awful.client.focus.bydirection("up")    end,   {description = "Фокус на верхнее окно",             group = "client"}),

        -- Переключаем окна по циклу
        awful.key({ modkey,           }, "Tab", function ()
            for client in awful.client.iterate(function () return true end) do
                client:raise()
            end
        end),

--    awful.client.focus.history.previous()
        --    if client.focus then
        --        client.focus:raise()
        --    end
        --end, {description = "go back", group = "client"}),

        awful.key({ modkey,           }, "+", function() awful.tag.incgap(1)                    end,    {description = "show the menubar", group = "launcher"}),
        awful.key({ modkey,           }, "-", function() awful.tag.incgap(-1)                   end,    {description = "show the menubar", group = "launcher"}),

        -- awful.key({ modkey,           }, "l", function () awful.tag.incmwfact( 0.05) end, {description = "increase master width factor", group = "layout"}),
        -- awful.key({ modkey,           }, "h", function () awful.tag.incmwfact(-0.05) end, {description = "decrease master width factor", group = "layout"}),
        -- awful.key({ modkey, shiftkey   }, "h", function () awful.tag.incnmaster( 1, nil, true) end, {description = "increase the number of master clients", group = "layout"}),
        -- awful.key({ modkey, shiftkey   }, "l", function () awful.tag.incnmaster(-1, nil, true) end, {description = "decrease the number of master clients", group = "layout"}),
        -- awful.key({ modkey, ctrlkey }, "h", function () awful.tag.incncol( 1, nil, true) end, {description = "increase the number of columns", group = "layout"}),
        -- awful.key({ modkey, ctrlkey }, "l", function () awful.tag.incncol(-1, nil, true) end, {description = "decrease the number of columns", group = "layout"}),
        -- awful.key({ modkey,           }, "space", function () awful.layout.inc( 1) end, {description = "select next", group = "layout"}),
        -- awful.key({ modkey, shiftkey   }, "space", function () awful.layout.inc(-1) end, {description = "select previous", group = "layout"}),
        -- awful.key({ modkey,           }, "w", function () mainmenu:show() end, {description = "show main menu", group = "awesome"}),

        -- Launchers
        awful.key({ modkey }, "d", function () awful.spawn(apps.rofi_launcher) end, {description = "run rofi", group = "launcher"}),
        awful.key({ modkey }, "p", function () awful.spawn(apps.rofi_search) end, {description = "run search", group = "launcher"}),

        awful.key({ }, "XF86MonBrightnessUp",   function () awful.spawn(apps.backlight .. ' s 10%+')    end, {description = "Увеличить яркость", group = "fn"}),
        awful.key({ }, "XF86MonBrightnessDown", function () awful.spawn(apps.backlight .. ' s 10%-')    end, {description = "Уменьшить яркость", group = "fn"}),
        awful.key({ }, "XF86AudioRaiseVolume",  function ()
            awful.spawn(apps.pactl.volume .. ' +10%')
            awesome.emit_signal('volume::change')
        end, {description = "Увеличить громкость", group = "fn"}),
        awful.key({ }, "XF86AudioMute",         function ()
            awful.spawn(apps.pactl.mute .. ' toggle')
            awesome.emit_signal('volume::change')
        end, {description = "Замутить", group = "fn"}),
        awful.key({ }, "XF86AudioLowerVolume",  function ()
            awful.spawn(apps.pactl.volume .. ' -10%')
            awesome.emit_signal('volume::change')
        end, {description = "Уменьшить громкость", group = "fn"}),
        awful.key({ }, "Print",                function () awful.spawn(apps.flameshot )                end, {description = "show the menubar", group = "fn"})

)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 0, 9 do
    globalkeys = gears.table.join(globalkeys,
            -- View tag only.
            awful.key({ modkey }, "#" .. i + 9,
                    function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                            tag:view_only()
                        end
                    end,
                    {description = "view tag #"..i, group = "tag"}),
            -- Toggle tag display.
            awful.key({ modkey, ctrlkey }, "#" .. i + 9,
                    function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                            awful.tag.viewtoggle(tag)
                        end
                    end,
                    {description = "toggle tag #" .. i, group = "tag"}),
            -- Move client to tag.
            awful.key({ modkey, shiftkey }, "#" .. i + 9,
                    function ()
                        if client.focus then
                            local tag = client.focus.screen.tags[i]
                            if tag then
                                client.focus:move_to_tag(tag)
                            end
                        end
                    end,
                    {description = "move focused client to tag #"..i, group = "tag"})
    )
end

return globalkeys
