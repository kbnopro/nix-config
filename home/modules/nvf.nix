{
  config,
  inputs,
  pkgs,
  mylib,
  ...
}:
let
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
  config.home.packages = [
    nvf.neovim
  ];
}
