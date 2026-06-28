{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.programs.quickshell;
  colors = config.background.colors;

  prettyColorsJSON = builtins.readFile (
    pkgs.runCommand "pretty.json" { nativeBuildInputs = [ pkgs.jq ]; } ''
      echo '${builtins.toJSON colors}' > ugly.json
      jq '.' ugly.json > $out
    ''
  );
in
{
  config = lib.mkIf cfg.enable {
    xdg.configFile."quickshell".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/modules/home/programs/gui/quickshell/qml";
    xdg.stateFile."quickshell/theme.json".text = prettyColorsJSON;
    programs.quickshell.systemd.enable = true;
    home.packages = with pkgs; [
      libnotify
    ];
  };
}
