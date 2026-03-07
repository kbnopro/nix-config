{ ... }:
{
  imports = [
    ../modules/background
  ];

  config = {
    background.path = "../background-images/purple-sunset.jpg";

    nixpkgs.hostPlatform = "aarch64-darwin";
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
      "pipe-operators"
    ];

    system.stateVersion = 6;
  };
}
