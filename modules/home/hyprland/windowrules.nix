{
  ...
}:

{
  wayland.windowManager.hyprland.settings = {
    window_rule = [
      {
        match = {
          title = ".*";
        };
        no_blur = true;
      }
      # "float on, match:title ^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$"
      # "center on, match:title ^(Open File)(.*)$"
      # "center on, match:title ^(Select a File)(.*)$"
      # "center on, match:title ^(Choose wallpaper)(.*)$"
      # "center on, match:title ^(Open Folder)(.*)$"
      # "center on, match:title ^(Save As)(.*)$"
      # "center on, match:title ^(Library)(.*)$"
      # "center on, match:title ^(File Upload)(.*)$"
      # "keep_aspect_ratio on, match:title ^(Picture(-| )in(-| )[Pp]icture)$"
      # "move 73% 72%, match:title ^(Picture(-| )in(-| )[Pp]icture)$"
      # "size 25%, match:title ^(Picture(-| )in(-| )[Pp]icture)$"
      # "float on, match:title ^(Picture(-| )in(-| )[Pp]icture)$"
      # "pin on, match:title ^(Picture(-| )in(-| )[Pp]icture)$"
      # "float on, match:title ^(Open File)(.*)$"
      # "float on, match:title ^(Select a File)(.*)$"
      # "float on, match:title ^(Choose wallpaper)(.*)$"
      # "float on, match:title ^(Open Folder)(.*)$"
      # "float on, match:title ^(Save As)(.*)$"
      # "float on, match:title ^(Library)(.*)$"
      # "float on, match:title ^(File Upload)(.*)$"
      # "rounding 10, match:title ^(TPM-FIDO)(.*)$"
      # "immediate,class:(steam_app)"
      # "noshadow,floating:0"
      # "xray 1, .*"
      # "noanim, walker"
      # "noanim, selection"
      # "noanim, overview"
      # "noanim, anyrun"
      # "noanim, indicator.*"
      # "noanim, osk"
      # "noanim, hyprpicker"
      # "blur, shell:*"
      # "ignorealpha 0.6, shell:*"
      # "noanim, noanim"
      # "blur, gtk-layer-shell"
      # "ignorezero, gtk-layer-shell"
      # "blur, launcher"
      # "ignorealpha 0.5, launcher"
      # "blur, notifications"
      # "ignorealpha 0.69, notifications"
    ];
  };
}
