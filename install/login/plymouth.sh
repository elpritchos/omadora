if [ "$(plymouth-set-default-theme)" != "sliced" ]; then
  omadora-exec omadora-refresh-plymouth
fi
