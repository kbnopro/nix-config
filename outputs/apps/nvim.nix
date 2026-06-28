{
  nixpkgs,
  flake-utils,
  ...
}@inputs:
flake-utils.lib.eachDefaultSystem (
  system:
  let
    pkgs = import nixpkgs {
      inherit system;
    };
    lib = pkgs.lib;
    mylib = import ../../lib { inherit lib pkgs; };

    colors =
      (import ../../modules/background/_color.nix {
        inherit lib pkgs;
        bgPath = ../../background-images/blue-sunset.jpg;
      }).colorAttrs;

    nvf = inputs.nvf.lib.neovimConfiguration {
      inherit pkgs;
      modules = [
        ../../modules/nvf
      ];
      extraSpecialArgs = {
        inherit mylib colors;
      };
    };
  in
  {
    apps.nvim = {
      type = "app";
      program = "${nvf.neovim}/bin/nvim";
    };
  }
)
