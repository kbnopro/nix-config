{
  lib,
  ...
}:
{
  wayland.windowManager.hyprland.settings = {
    monitor = [
      {
        # default for new monitor
        output = "";
        mode = "preferred";
        position = "auto";
        scale = 1;
      }
      {
        # vertical monitor (home - vic)
        output = "desc:Shenzhen KTC Technology Group H27T22C 0x00000001";
        mode = "2560x1440@180.00Hz";
        position = "0x0";
        scale = 1;
        bitdepth = 10;
        transform = 1;
      }
      {
        # horizontal monitor (home - vic)
        output = "desc:AOC Q27G40ZDF RK2S2JA008358";
        mode = "2560x1440@240.00Hz";
        position = "1440x500";
        scale = 1;
        bitdepth = 10;
      }
    ];
    workspace_rule = [
      {
        workspace = "name:permanent_ver_home_vic";
        monitor = "desc:Shenzhen KTC Technology Group H27T22C 0x00000001";
        default = true;
        layout_opts = {
          direction = "down";
          fullscreen_on_one_column = false;
        };
      }
    ]
    ++ (
      (lib.range 1 10)
      |> (map (i: {
        workspace = i;
        monitor = "desc:AOC Q27G40ZDF RK2S2JA008358";
        default = true;
      }))
    );

    # workspace =
    #   (
    #     (lib.range 1 10)
    #     |> (map (i: "${toString i},monitor:desc:AOC Q27G40ZDF RK2S2JA008358, default:true"))
    #   )
    #   ++ [
    #     "name:ver,monitor:desc:Shenzhen KTC Technology Group H27T22C 0x00000001, default:true"
    #   ];
  };
}
