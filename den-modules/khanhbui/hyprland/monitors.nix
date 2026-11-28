{
  # machine specific configuration - fw13p
  nixos.configurations.fw13p = {
    module.home-manager.sharedModules = [
      {
        wayland.windowManager.hyprland.settings = {
          monitor = [
            {
              output = "eDP-1";
              mode = "2880x1920@120.00000";
              position = "0x0";
              scale = 1.60;
              bitdepth = 10;
              vrr = 1;
            }
          ];
        };
      }
    ];
  };

  users.khanhbui.home.gui = {
    wayland.windowManager.hyprland.settings = {
      monitor = [
        {
          # default for new monitor
          output = "";
          mode = "preferred";
          position = "auto";
          scale = 1;
        }
      ];
    };
  };
}
