{
  config, lib, ...
}: 

with lib;

let
  cfg = config.programs.fuzzel;
in {
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
      bind = [
        "Super, Space, exec, pkill fuzzel || fuzzel"
      ];
    };
  };
}
