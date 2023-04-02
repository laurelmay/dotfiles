if status is-login
  if test -z "$DISPLAY"; and test "$XDG_VTNR" -eq 1
    # Environment variables
    set -gx MOZ_ENABLE_WAYLAND 1
    set -gx JAVA_AWT_WM_NONREPARENTING 1
    set -gx XDG_CURRENT_DESKTOP sway

    # Start sway with logging enabled
    exec sway &> /var/run/user/"$(id -u)"/sway.log
  end
end
