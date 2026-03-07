{
  config,
  lib,
  pkgs,
  ...
}:
let
  bgPath = config.background.path;
  cfgEnable = config.services.swww.enable;
  myScript = pkgs.writeShellApplication {
    name = "set-wallpaper";
    runtimeInputs = [
      pkgs.swww
    ];
    text = ''
      swww img "${bgPath}" --transition-step 100 --transition-fps 120 \
        --transition-type grow --transition-angle 30 --transition-duration 1 \
        --transition-pos "0,0"
    '';
  };
in
{
  config = (
    lib.mkIf cfgEnable {
      # This will fail when swww is not active yet due to race conditions, so voiding the error with || true.
      services.swww.extraArgs = [
        "--format"
        "xrgb"
      ];
      home.activation.setWallpaper = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        ${myScript}/bin/set-wallpaper || true
      '';
    }
  );
}
