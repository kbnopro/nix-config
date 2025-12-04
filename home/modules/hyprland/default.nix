{
  mylib, ... 
}:

{
  imports = mylib.scanPaths ./.;

  wayland.windowManager.hyprland = {
    package = null;
    portalPackage = null;
  };
}

