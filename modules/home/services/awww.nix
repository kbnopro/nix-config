{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfgEnable = config.services.awww.enable;

  bgPath = config.background.path;
  myScript = pkgs.writeShellApplication {
    name = "set-wallpaper";
    runtimeInputs = [
      pkgs.awww
    ];
    text = ''
      awww img "${bgPath}" --transition-step 100 --transition-fps 120 \
        --transition-type grow --transition-angle 30 --transition-duration 1 \
        --transition-pos "0,0"
    '';
  };
in
{
  config = (
    lib.mkIf cfgEnable {
      # This will fail when awww is not active yet due to race conditions, so voiding the error with || true.
      services.awww.extraArgs = [
        "--format"
        "xrgb"
      ];
      home.activation.setWallpaper = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        ${myScript}/bin/set-wallpaper || true
      '';
    }
  );
}
