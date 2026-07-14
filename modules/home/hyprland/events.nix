{
  lib,
  config,
  pkgs,
  ...
}:
let
  background = config.background;

  script = pkgs.writeShellApplication {
    name = "set-wallpaper";
    runtimeInputs = [
      pkgs.awww
    ];
    text = ''
      awww img "${background.path}" --transition-step 100 --transition-fps 120 \
        --transition-type grow --transition-angle 30 --transition-duration 1 \
        --transition-pos "0,0"
    '';
  };
in
{
  wayland.windowManager.hyprland.settings = {
    on = [
      {
        _args = [
          "hyprland.start"
          (lib.generators.mkLuaInline ''
            function()
              hl.dsp.exec_cmd('${script}/bin/set-wallpaper || true')
            end
          '')
        ];
      }
    ];
  };
}
