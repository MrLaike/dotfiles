local awful = require("awful")
local naughty = require("naughty")
local beautiful = require("beautiful")
local apps = require("configs.apps")

-- задаем теги
local tags = {
    {
        type = "terminal",
        title = "一",
        --icon = icons.terminal,
        default_app = apps.terminal,
        layout = awful.layout.suit.tile
    },
    {
        type = "internet",
        title = "二",
        --icon = icons.web_browser,
        default_app = apps.browser,
    },
    {
        type = "code",
        title = "三",
        --icon = icons.text_editor,
        default_app = apps.editor,
    },
    {
        type = "files",
        title = "四",
        --icon = icons.file_manager,
        default_app = apps.filemanager,
        --gap = beautiful.useless_gap,
        --layout = awful.layout.suit.tile
    },
    {
        type = "multimedia",
        title = "五",
        --icon = icons.multimedia,
        default_app = apps.multimedia,
        gap = 0
    },
    {
        type = "games",
        title = "六",
        --icon = icons.games,
        default_app = apps.game,
    },
    {
        type = "graphics",
        title = "七",
        --icon = icons.graphics,
        default_app = apps.graphics,
    },
    {
        type = "sandbox",
        title = "八",
        --icon = icons.sandbox,
        default_app = apps.sandbox,
        gap = 0
    },
    {
        type = "any",
        title = "九",
        --icon = icons.development,
        default_app = apps.development,
    }
    -- {
    --   type = "social",
    --   icon = icons.social,
    --   default_app = "discord",
    --   gap = beautiful.useless_gap
    -- }
}

awful.layout.layouts = {
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.tile,
    awful.layout.suit.floating,
    awful.layout.suit.max,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}

-- Create tags for each screen
awful.screen.connect_for_each_screen(function(screen)
    for i, tag in pairs(tags) do
        awful.tag.add(
            tag.title or i,
            {
                --icon = tag.icon,
                icon_only = false,
                layout = tag.layout or awful.layout.suit.tile,
                gap_single_client = true,
                gap = tag.gap,
                screen = screen,
                default_app = tag.default_app,
                selected = i == 1
            }
        )
    end
end)
