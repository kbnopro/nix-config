{ ... }:
{
  config = {
    background.path = ../background-images/purple-sunset.jpg;

    nixpkgs.hostPlatform = "aarch64-darwin";
    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
      "pipe-operators"
    ];

    system.stateVersion = 6;
  };
}
