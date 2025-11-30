{
  pkgs, ...
}:

{
  imports = [
    ./microsoft-edge.nix
  ];

  home.packages = [ pkgs.discord ];
}
