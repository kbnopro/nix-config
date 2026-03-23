{ pkgs, ... }:
{
  config = {
    # Users
    system.primaryUser = "khanhbui";
    users.knownUsers = [ "khanhbui" ];
    users.users.khanhbui = {
      description = "Khanh Bui";
      shell = pkgs.fish;
      uid = 501;
    };
    programs.fish.enable = true;

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
