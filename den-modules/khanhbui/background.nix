{
  users.khanhbui.home.gui =
    nixosArgs@{
      config,
      pkgs,
      lib,
      ...
    }:
    let
      bgPath = config.backgroundPath;
      colors = config.colors;
      bgCropGravity = config.backgroundCropGravity;
      myScript = pkgs.writeShellApplication {
        name = "set-wallpaper";
        runtimeInputs = [
          pkgs.awww
        ];
        text = ''
          awww img "${bgPath}" --transition-step 100 --transition-fps 120 \
            --transition-type grow --transition-angle 30 --transition-duration 1 \
            --transition-pos "0,0" --resize "crop" --crop-gravity "${bgCropGravity}" \
        '';
      };
    in
    {
      gtk.colorScheme = if colors.darkmode == true then "dark" else "light";
      services.awww = {
        enable = true;
        extraArgs = [
          "--format"
          "xrgb"
        ];
      };
      home.activation.setWallpaper = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        ${myScript}/bin/set-wallpaper || true
      '';
    };
}
