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

    system.stateVersion = 6;
  };
}
