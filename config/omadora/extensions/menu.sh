# Overwrite parts of the omadora-menu with user-specific submenus.
# See $OMADORA_PATH/bin/omadora-menu for functions that can be overwritten.
#
# WARNING: Overwritten functions will obviously not be updated when Omadora changes.
#
# Example of minimal system menu:
#
# show_system_menu() {
#   case $(menu "System" "  Lock\n󰐥  Shutdown") in
#   *Lock*) omadora-lock-screen ;;
#   *Shutdown*) omadora-cmd-shutdown ;;
#   *) back_to show_main_menu ;;
#   esac
# }
