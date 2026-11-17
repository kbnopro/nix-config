{
  nixos.modules.base = {
    users.users.khanhbui.extraGroups = [ "wheel" ];
  };
}
