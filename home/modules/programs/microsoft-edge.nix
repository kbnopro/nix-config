{
  pkgs, lib, config,...
}: 

with lib;

let 
  cfg = config.programs.edge;

  edgeFlags = [
    "--password-store=gnome-libsecret"
    "--ozone-platform=wayland"
    "--gtk-version=4"
    "--enable-features=TouchPadOverscrollHistoryNavigation,UseOzonePlatform"
    "--enable-wayland-ime"
    "--disable-features=WaylandWpColorManager"
  ];

  edge = pkgs.microsoft-edge.override {
    commandLineArgs = builtins.concatStringsSep " " edgeFlags;
  };

in {
  options.programs.edge = {
    enable = mkEnableOption "Microsoft Edge";
  };

  config = mkIf cfg.enable {
    home.packages = [edge]; 
    wayland.windowManager.hyprland.settings = {
      bind = [
        "SUPER, E, exec, microsoft-edge"
      ];
    };
  };
}

