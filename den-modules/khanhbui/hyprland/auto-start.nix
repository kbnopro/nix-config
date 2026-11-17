{
  users.khanhbui = {
    nixos.pc = {
      programs.hyprland = {
        enable = true;
        withUWSM = true;
      };
    };

    home.gui = {
      wayland.windowManager.hyprland.enable = true;
      programs.fish.loginShellInit = ''
        if uwsm check may-start -q
          exec start-hyprland
        end
      '';
      # programs.fish.loginShellInit = ''
      #   if uwsm check may-start -q
      #     exec uwsm start hyprland-uwsm.desktop
      #   end
      # '';
    };
  };
}
