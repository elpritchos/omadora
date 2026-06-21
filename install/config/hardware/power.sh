if ls /sys/class/power_supply/BAT* &>/dev/null; then
  powerprofilesctl set balanced || true
else
  powerprofilesctl set performance || true
fi
