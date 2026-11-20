{
  users.khanhbui.home.base = {
    programs.btop = {
      enable = true;
      settings = {
        color_theme = "TTY";
        theme_background = false;
        truecolor = true;
        vim_keys = true;
        shown_boxes = "mem net proc cpu gpu0";
      };
    };
  };
}

# TODO: add this to nvidia module
# (lib.mkIf cfg.enableNvidia {
#   programs.btop.package = (
#     pkgs.symlinkJoin {
#       name = "btop-wrapped";
#       paths = [ pkgs.btop ];
#       buildInputs = [ pkgs.makeWrapper ];
#       postBuild = ''
#         wrapProgram $out/bin/btop \
#           --prefix LD_LIBRARY_PATH : "${pkgs.linuxPackages.nvidia_x11}/lib"
#       '';
#     }
#   );
# })
