local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local spawn = require("awful.spawn")
local awful = require("awful")
local watch = require("awful.widget.watch")

local function GET_VOLUME_CMD() return "pacmd list-sinks | awk '/^\\svolume:/ {print \"volume: \"$5}; /muted:/ {print \"muted: \"$2};' | awk 'FNR <=2'" end
local function GET_VOLUME_BASH() return "bash -c \"pacmd list-sinks | awk '/^\\svolume:/ {print \\\"volume: \\\"\\$5}; /muted:/ {print \\\"muted: \\\"\\$2};\' | awk 'FNR <=2'\"" end
local function TOG_VOLUME_CMD(device)       return "pactl set-sink-mute "   .. device end
local function INC_VOLUME_CMD(device, step)
    local get_volume = GET_VOLUME_CMD()
    return "pactl set-sink-volume " .. device .. " +" .. step .. "%;" .. get_volume
end
local function DEC_VOLUME_CMD(device, step)
    local get_volume = GET_VOLUME_CMD()
    return "pactl set-sink-volume " .. device .. " -" .. step .. "%;" .. get_volume
end

local rounded_corners = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 2.5)
end

local update_volume = function (widget, output)


    local muted = string.match(output, ":%s(%a+)")
    local volume = string.match(output, "%d+")

    if      muted == 'no'  then widget:mute()
    elseif  muted == 'yes'   then widget:unmute()
    end

    widget:set_volume_level(volume)
end

-- TODO Добавить и микрофон
local thickness     = beautiful.volume_thickness    or 2
local fg_color      = beautiful.volume_fg_color     or beautiful.fg_color
local bg_color      = beautiful.volume_bg_color     or "#ffffff22"
local mute_color    = beautiful.volume_mute_color   or "#00eeee"
local size          = beautiful.volume_size         or 20

 local volume = wibox.widget {
    {
        image   = "",
        resize  = true,
        widget  = wibox.widget.imagebox
    },
    max_value       = 100,
    thickness       = thickness,
    start_angle     = 4.71238, --3/2 * math.pi,
    rounded_edge    = true,
    forced_height   = size,
    forced_width    = size,
    bg              = bg_color,
    padding         = 2,
    widget          = wibox.container.arcchart,

    set_volume_level = function(self, new_value)
        self.value = new_value
    end,
    mute = function(self)
        self.colors = { mute_color }
    end,
    unmute = function(self)
        self.colors = { fg_color }
    end

}

local step = 10
local device = 1

function volume:inc(s)

    spawn.easy_async_with_shell(INC_VOLUME_CMD(device, s or step), function(stdout) update_volume(volume, stdout) end)
end

function volume:dec(s)
    spawn.easy_async_with_shell(DEC_VOLUME_CMD(device, s or step), function(stdout) update_volume(volume, stdout) end)
end

function volume:toggle()
    spawn.easy_async_with_shell(TOG_VOLUME_CMD(device), function(stdout) update_volume(volume, stdout) end)
end

volume:buttons(
        awful.util.table.join(
                awful.button({}, 4, function() volume:inc() end),
                awful.button({}, 5, function() volume:dec() end),
                awful.button({}, 1, function() volume:toggle() end)
        )
)

awesome.connect_signal("volume::change", function()
    spawn.easy_async_with_shell(GET_VOLUME_CMD(), function(stdout) update_volume(volume, stdout) end)
end)

-- TODO сменить таймер на emit_signal при изменение звука
--watch(GET_VOLUME_BASH(), 1, update_volume, volume)

return volume