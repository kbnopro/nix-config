{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.programs.btop;
in
{
  options.programs.btop = {
    enableNvidia = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable NVIDIA support for btop.";
    };
  };

  config = lib.mkMerge [
    {
      programs.btop = {
        settings = {
          color_theme = "TTY";
          theme_background = false;
          truecolor = true;
          vim_keys = true;
          shown_boxes = "mem net proc cpu gpu0";
        };
      };
    }
    (lib.mkIf cfg.enableNvidia {
      programs.btop.package = (
        pkgs.symlinkJoin {
          name = "btop-wrapped";
          paths = [ pkgs.btop ];
          buildInputs = [ pkgs.makeWrapper ];
          postBuild = ''
            wrapProgram $out/bin/btop \
              --prefix LD_LIBRARY_PATH : "${pkgs.linuxPackages.nvidia_x11}/lib"
          '';
        }
      );
    })
  ];
}
