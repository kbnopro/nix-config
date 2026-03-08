{
  config,
  inputs,
  pkgs,
  mylib,
  lib,
  ...
}:
let
  cfg = config.programs.nvf;
  colors = config.background.colors;

  # nvf stuffs
  nvf = inputs.nvf.lib.neovimConfiguration {
    inherit pkgs;
    modules = [
      ../../nvf
    ];
    extraSpecialArgs = {
      inherit mylib colors;
    };
  };

in
{
  options = {
    programs.nvf.enable = lib.mkEnableOption "Neovim with nvf configuration";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      nvf.neovim
    ];
  };
}
