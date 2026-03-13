{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.programs.intellij;

  inherit (pkgs.jetbrains) idea-oss;

  plugins = inputs.nix-jetbrains-plugins.lib.pluginsForIde pkgs idea-oss [
    "com.github.copilot"
    "IdeaVIM"
  ];

in
{
  options = {
    programs.intellij = {
      enable = lib.mkEnableOption "Enable IntelliJ IDEs";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      (pkgs.jetbrains.plugins.addPlugins idea-oss (lib.attrValues plugins))
    ];
  };
}
