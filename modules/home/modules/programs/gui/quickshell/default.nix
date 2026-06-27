{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.programs.quickshell;
  colors = config.background.colors;
in
{
  config = lib.mkIf cfg.enable {
    xdg.configFile."quickshell".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/modules/home/modules/programs/gui/quickshell/qml";
    xdg.cacheFile."quickshell/theme.json".text = builtins.toJSON colors;
    programs.quickshell.systemd.enable = true;
    home.packages = with pkgs; [
      libnotify
    ];
  };
}
