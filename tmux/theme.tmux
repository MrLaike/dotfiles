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

# short for Theme-Colour
source ~/.cache/wal/colors.sh

tmux_set status-interval 1
tmux_set status on
tmux_set status-keys vi
tmux_set status-justify centre
tmux_set status-position top

# Basic status bar colors
tmux_set status-fg "$foreground"
tmux_set status-bg "$background"
tmux_set status-attr none

# tmux-prefix-highlight
tmux_set @prefix_highlight_fg "$foreground"
tmux_set @prefix_highlight_bg "$background"
tmux_set @prefix_highlight_show_copy_mode 'on'
tmux_set @prefix_highlight_copy_mode_attr "fg=$foreground,bg=$background,bold"
tmux_set @prefix_highlight_output_prefix "#[fg=$foreground]#[bg=$background]$left_arrow_icon#[bg=$background]#[fg=$foreground]"
tmux_set @prefix_highlight_output_suffix "#[fg=$fo]#[bg=$background]$right_arrow_icon"

tmux_set status-left ""
tmux_set status-right ""
# Window status
tmux_set window-status-format "  "
tmux_set window-status-current-format "#[fg=$color3,bg=$background]  "

# Window separator
tmux_set window-status-separator ""

# Pane border
local pane_border_status pane_border_style \
    pane_active_border_style pane_left_separator pane_middle_separator \
    pane_right_separator pane_number_position pane_format
  pane_status_enable="no"
  pane_border_status="off"
  pane_border_style="fg=${color1}"
  pane_active_border_style="#{?pane_in_mode,fg=${color7},#{?pane_synchronized,fg=${color8},fg=${color9}}}"
  pane_left_separator="█"
  pane_middle_separator="█"
  pane_right_separator="█"
  pane_number_position="left"

setw pane-border-status "$pane_border_status"
setw pane-active-border-style "$pane_active_border_style"
setw pane-border-style "$pane_border_style"

# Message
tmux_set message-style "fg=$foreground,bg=$background"

# Command message
tmux_set message-command-style "fg=$foreground,bg=$background"

# Copy mode highlight
tmux_set mode-style "bg=$foreground,fg=$foreground"
