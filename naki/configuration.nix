{ ... }:
{
  config = {
    background.path = ../background-images/purple-sunset.jpg;

    # Users
    system.primaryUser = "theatran";
    users.users.theatran = {
      description = "Thuc Anh";
    };

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
