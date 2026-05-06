{
  ...
}:

{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "bash ${./onMonitorAdd.sh}" # [hidden] Reload Hyprland on config change
    ];
  };

}
