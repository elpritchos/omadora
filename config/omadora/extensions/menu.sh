# Overwrite parts of the omadora-menu with user-specific submenus.
# See $OMADORA_PATH/bin/omadora-menu for functions that can be overwritten.
#
# WARNING: Overwritten functions will obviously not be updated when Omadora changes.
#
# Example of minimal system menu:
#
# show_system_menu() {
#   case $(menu "System" "  Lock\n󰐥  Shutdown") in
#   *Lock*) omactl system lock ;;
#   *Shutdown*) omactl system shutdown ;;
#   *) back_to show_main_menu ;;
#   esac
# }
#
# Example of overriding just the about menu action: (Using zsh instead of bash (default))
#
# show_about() {
#   exec omadora-launch-or-focus-tui "zsh -c 'fastfetch; read -k 1'"
# }
