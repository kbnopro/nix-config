{
  ... 
}:

{
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
  };

  imports = [
    ./inputs.nix
    ./keybinds.nix
    ./monitors.nix
  ];

}

