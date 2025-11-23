{
  pkgs, ...
}: 

let 
  edgeFlags = [
    # until i setup gnome
    # "--password-store=gnome-libsecret"
    "--ozone-platform=wayland"
    "--gtk-version=4"
    "--enable-features=TouchPadOverscrollHistoryNavigation,UseOzonePlatform"
    "--enable-wayland-ime"
    "--disable-features=WaylandWpColorManager"
  ];
  edge = pkgs.microsoft-edge.override {
    commandLineArgs = builtins.concatStringsSep " " edgeFlags;
  };
in {
  config = {
    home.packages = [ edge ];
  };
}

