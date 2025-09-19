# Add a default plymouth theme from https://github.com/adi1090x/plymouth-themes
if [ "$(plymouth-set-default-theme)" != "sliced" ]; then
  omadora-refresh-plymouth 
fi
