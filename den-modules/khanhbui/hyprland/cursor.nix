{
  users.khanhbui.home.gui =
    _homeArgs@{ pkgs, ... }:
    {
      home.packages = with pkgs; [
        rose-pine-hyprcursor
      ];

      wayland.windowManager.hyprland.settings = {
        env = [
          {
            _args = [
              "HYPRCURSOR_THEME"
              "rose-pine-hyprcursor"
            ];
          }
        ];
      };
    };
}
