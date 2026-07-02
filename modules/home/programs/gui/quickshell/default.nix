{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.programs.quickshell;
  colors = config.background.colors;

  jsonColors = (builtins.toJSON (colors |> (lib.filterAttrs (k: _: k != "withHashtag"))));

  prettyColorsJSON = builtins.readFile (
    pkgs.runCommand "pretty.json" { nativeBuildInputs = [ pkgs.jq ]; } ''
      echo '${jsonColors}' > ugly.json
      jq '.' ugly.json > $out
    ''
  );

  pathToConfig = "${config.home.homeDirectory}/nixos-config/modules/home/programs/gui/quickshell";

  inherit (config.lib.file) mkOutOfStoreSymlink;
in
{
  config = lib.mkIf cfg.enable {
    xdg.configFile."quickshell".source = mkOutOfStoreSymlink "${pathToConfig}/qml";
    xdg.configFile."shell.json".source = mkOutOfStoreSymlink "${pathToConfig}/shell.json";
    xdg.stateFile."quickshell/scheme.json" = {
      text = prettyColorsJSON;
      # Manually trigger the reload
      onChange = ''
        ${cfg.package}/bin/qs ipc call themeFile reload
      '';
    };
    programs.quickshell.systemd.enable = true;
    home.packages = with pkgs; [
      libnotify
    ];
  };
}
