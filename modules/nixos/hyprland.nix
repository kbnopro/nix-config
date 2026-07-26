{ config, lib, ... }:
let
  cfg = config.programs.hyprland;
in
{
  options = {
    programs.hyprland = {
      hmUser = lib.mkOption {
        type = lib.types.str;
        default = "khanhbui";
        description = "The user to use for home-manager when enabling Hyprland.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs.hyprland = {
      withUWSM = true;
    };
    home-manager.users."${cfg.hmUser}" = {
      wayland.windowManager.hyprland.enable = true;
      programs.fish.loginShellInit = ''
        if uwsm check may-start -q
          exec uwsm start hyprland-uwsm.desktop 
        end
      '';
      services.hypridle = {
        enable = true;
        settings = {
          listener = [
            {
              timeout = 60 * 5; # 5 minutes
              on-timeout = ''hyprctl eval 'hl.dispatch(hl.dsp.dpms({ action = "disable" }))' '';
              on-resume = ''hyprctl eval 'hl.dispatch(hl.dsp.dpms({ action = "enable" }))' '';
            }
          ];
        };
      };
    };
  };
}
