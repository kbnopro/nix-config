{
  lib,
  ...
}:
{
  wayland.windowManager.hyprland.settings = {
    monitor = [
      ",preferred,auto,1" # Configure for all unspecified monitors
      "desc:Shenzhen KTC Technology Group H27T22C 0x00000001,2560x1440@144.00Hz,0x0,1,bitdepth,10,transform,1"
      "desc:AOC Q27G40ZDF RK2S2JA008358, 2560x1440@165.00Hz,1440x700,1,bitdepth,10"
    ];
    workspace =
      (
        (lib.range 1 10)
        |> (map (i: "${toString i},monitor:desc:AOC Q27G40ZDF RK2S2JA008358, default:true"))
      )
      ++ [
        "name:ver,monitor:desc:Shenzhen KTC Technology Group H27T22C 0x00000001, default:true"
      ];
  };
}
