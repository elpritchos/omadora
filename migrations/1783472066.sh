echo "Refreshing configs for changes..."
omactl config restore-path starship.toml
omactl config restore-path tmux/tmux.conf
omactl config restore-path systemd/user/omadora-weather-check.timer

echo "Restarting services..."
omactl service daemon-reload
omactl service restart omadora-weather-check.timer
