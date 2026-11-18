{
  nixos.modules.base = {
    programs.fish.enable = true;
  };
  users.khanhbui.home.base = {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        fish_vi_key_bindings
      '';
    };
  };
}
