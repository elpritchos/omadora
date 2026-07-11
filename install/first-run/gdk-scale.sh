# Set the default GDK_SCALE from what the monitor is currently reporting

sed -i -E "s|^local omadora_gdk_scale = .*|local omadora_gdk_scale = $(omadora-exec omadora-hyprland-monitor-scale)|" ~/.config/hypr/monitors.lua
