{
  pkgs,
  config,
  lib,
  ...
}:
let
  bgPath = config.background.path;

  myScript = pkgs.writeShellScriptBin "set-wallpaper" ''
    set -e
    /usr/bin/osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"${bgPath}\"";
  '';

in
{
  config = (
    lib.mkIf pkgs.stdenv.isDarwin {
      home.activation.setWallpaper = lib.hm.dag.entryAfter [ "revealHomeLibraryDirectory" ] ''
        ${myScript}/bin/set-wallpaper || true
      '';
    }
  );
}
