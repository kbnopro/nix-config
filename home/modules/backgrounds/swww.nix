{
  config,
  lib,
  pkgs,
  ...
}:
let
  bgPath = config.background.path;
  cfg = config.services.swww;
  myScript = pkgs.writeShellApplication {
    name = "set-wallpaper";
    runtimeInputs = [
      pkgs.swww
      pkgs.jq
      pkgs.bc
      pkgs.hyprland
      pkgs.coreutils
    ];
    text = ''
      swww img "${bgPath}" --transition-step 100 --transition-fps 120 \
        --transition-type grow --transition-angle 30 --transition-duration 1 \
        --transition-pos "0,0"
    '';
  };
in
{
  config = lib.mkMerge [
    {
      services.swww.extraArgs = [
        "--format"
        "xrgb"
      ];
    }
    (lib.mkIf cfg.enable {
      home.activation.setWallpaper = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        ${myScript}/bin/set-wallpaper
      '';
    })
  ];
}
