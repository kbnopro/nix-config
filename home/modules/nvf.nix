{
  config,
  inputs,
  pkgs,
  mylib,
  ...
}:
let
  colors = config.background.colors;

  aliasNeovim =
    neovim: suffix:
    let
      binPaths = builtins.attrNames (builtins.readDir "${neovim}/bin");

      aliasedBins = builtins.map (
        bin:
        pkgs.writeShellScriptBin "${bin}-${suffix}" ''
          #!/bin/sh
          exec "${neovim}/bin/${bin}" "$@"
        ''
      ) binPaths;
    in
    aliasedBins;

  # nvf stuffs
  fullNeovim = inputs.nvf.lib.neovimConfiguration {
    inherit pkgs;
    modules = [
      ../../nvf/full.nix
    ];
    extraSpecialArgs = {
      inherit mylib colors;
    };
  };

  uniNeovim = inputs.nvf.lib.neovimConfiguration {
    inherit pkgs;
    modules = [
      ../../nvf/uni.nix
    ];
    extraSpecialArgs = {
      inherit mylib colors;
    };
  };

  neovimPackages = pkgs.symlinkJoin {
    name = "neovim-packages";
    paths = [
      fullNeovim.neovim
      (aliasNeovim uniNeovim.neovim "uni")
    ];
  };

in
{
  config.home.packages = [
    neovimPackages
  ];
}
