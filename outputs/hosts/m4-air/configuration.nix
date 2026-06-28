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

    # Karabiner (still not working, so we resort to brew)
    # services.karabiner-elements.enable = true;
    services.my-karabiner.enable = true;

    nixpkgs.hostPlatform = "aarch64-darwin";

    system.stateVersion = 6;
  };
}
