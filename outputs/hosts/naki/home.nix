{
  lib,
  ...
}:
{
  home = {
    username = "theatran";
    homeDirectory = lib.mkForce "/Users/theatran";
    stateVersion = "25.05";
  };

  programs = {
    spicetify.enable = true;
  };
}
