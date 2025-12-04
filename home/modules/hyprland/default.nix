{
  mylib, config, lib, pkgs,  ... 
}:

with lib;

let
  cfg = config.wayland.windowManager.hyprland;
in {
  imports = mylib.scanPaths ./.;

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      package = null;
      portalPackage = null;
    };
    home.packages = with pkgs; [
      brightnessctl
    ];
  };
}

