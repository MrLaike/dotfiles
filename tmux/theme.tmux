#!/usr/bin/env bash

# $1: option
# $2: default value
tmux_get() {
    local value="$(tmux show -gqv "$1")"
    [ -n "$value" ] && echo "$value" || echo "$2"
}

# $1: option
# $2: value
tmux_set() {
    tmux set-option -gq "$1" "$2"
}

# Options
right_arrow_icon=$(tmux_get '@tmux_power_right_arrow_icon' '')
left_arrow_icon=$(tmux_get '@tmux_power_left_arrow_icon' '')
upload_speed_icon=$(tmux_get '@tmux_power_upload_speed_icon' '')
download_speed_icon=$(tmux_get '@tmux_power_download_speed_icon' '')
session_icon="$(tmux_get '@tmux_power_session_icon' '')"
user_icon="$(tmux_get '@tmux_power_user_icon' '')"
date_icon="$(tmux_get '@tmux_power_date_icon' '')"
date_format=$(tmux_get @tmux_power_date_format '%F')
# short for Theme-Colour
source ~/.cache/wal/colors.sh

TC=$(tmux_get '@tmux_power_theme' $foreground)

# Status options
tmux_set status-interval 1
tmux_set status on

# Basic status bar colors
tmux_set status-fg "$foreground"
tmux_set status-bg "$background"
tmux_set status-attr none

# tmux-prefix-highlight
tmux_set @prefix_highlight_fg "$foreground"
tmux_set @prefix_highlight_bg "$background"
tmux_set @prefix_highlight_show_copy_mode 'on'
tmux_set @prefix_highlight_copy_mode_attr "fg=$TC,bg=$background,bold"
tmux_set @prefix_highlight_output_prefix "#[fg=$TC]#[bg=$background]$left_arrow_icon#[bg=$background]#[fg=$foreground]"
tmux_set @prefix_highlight_output_suffix "#[fg=$TC]#[bg=$background]$right_arrow_icon"

# Left side of status bar
tmux_set status-left-bg "$background"
tmux_set status-left-fg "$foreground"
tmux_set status-left-length 150
tmux_set status-position top
user=$(whoami)
# LS="#[fg=$TC,bg=$color06,nobold]$left_arrow_icon#[fg=$color3,bg=$TC,bold] $user_icon $user@#h #[fg=$TC,bg=$color06,nobold]#[fg=$TC,bg=$color06] $session_icon #S "
tmux_set status-left "$LS"

# Right side of status bar
tmux_set status-right-bg "$background"
tmux_set status-right-fg "$color12"
tmux_set status-right-length 150
sessions="#[fg=$color06,bg=$TC]$left_arrow_icon#[fg=$TC,bg=$color06] $session_icon #S "

tmux_set "$sessions"

tmux_set status-right ""

# Window status
tmux_set window-status-format " #I #W  "
tmux_set window-status-current-format "#[fg=$color3,bg=$background] #I#[fg=$color3,bg=$background] #W  "

# Window separator
tmux_set window-status-separator ""

# Current window status
tmux_set window-status-current-statys "fg=$TC,bg=$background"

# Pane border
local pane_border_status pane_border_style \
    pane_active_border_style pane_left_separator pane_middle_separator \
    pane_right_separator pane_number_position pane_format
  pane_status_enable=$(get_tmux_option "@catppuccin_pane_status_enabled" "no") # yes
  pane_border_status=$(get_tmux_option "@catppuccin_pane_border_status" "off") # bottom
  pane_border_style=$(
    get_interpolated_tmux_option "@catppuccin_pane_border_style" "fg=${color1}"
  )
  pane_active_border_style=$(
    get_interpolated_tmux_option "@catppuccin_pane_active_border_style" \
      "#{?pane_in_mode,fg=${color7},#{?pane_synchronized,fg=${color8},fg=${color9}}}"
  )
  pane_left_separator=$(get_tmux_option "@catppuccin_pane_left_separator" "█")
  pane_middle_separator=$(get_tmux_option "@catppuccin_pane_middle_separator" "█")
  pane_right_separator=$(get_tmux_option "@catppuccin_pane_right_separator" "█")
  pane_number_position=$(get_tmux_option "@catppuccin_pane_number_position" "left") # right, left

setw pane-border-status "$pane_border_status"
setw pane-active-border-style "$pane_active_border_style"
setw pane-border-style "$pane_border_style"

# Message
tmux_set message-style "fg=$TC,bg=$background"

# Command message
tmux_set message-command-style "fg=$TC,bg=$background"

# Copy mode highlight
tmux_set mode-style "bg=$TC,fg=$foreground"
