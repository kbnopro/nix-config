{
  pkgs,
  ...
}:

{
  wayland.windowManager.hyprland.settings = {
    env = [
      "HYPRCURSOR_THEME,rose-pine-hyprcursor"
    ];
  };
  home.packages = with pkgs; [
    rose-pine-hyprcursor
  ];
}
