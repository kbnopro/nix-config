{ lib, ... }: {
  users.khanhbui.home.gui = { config, ... }: {
    wayland.windowManager.hyprland.settings = {
      bind = [
        {
          _args = [
            "SUPER + T"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd('ghostty +new-window')")
          ];
        }
      ];
    };
    programs.ghostty = with config.colors.withHashtag; {
      enable = true;
      settings = {
        app-notifications = "no-clipboard-copy";
        background = surface;
        foreground = onSurface;
        background-opacity = 0.9;
        font-size = 10;
        window-padding-x = 16;
        window-padding-y = 16;
        confirm-close-surface = false;
        keybind = [
          "clear" # clear all default keybinds to define it here, we can move this to Zellij / tmux config later
          "ctrl+shift+c=copy_to_clipboard"
          "ctrl+shift+v=paste_from_clipboard"
          "ctrl+shift+a=select_all"
          "ctrl+shift+,=reload_config"
          "ctrl+shift+p=toggle_command_palette"

          "ctrl+equal=increase_font_size:1"
          "ctrl++=increase_font_size:1"
          "ctrl+-=decrease_font_size:1"
          "ctrl+0=reset_font_size"

          "copy=copy_to_clipboard"
          "paste=paste_from_clipboard"
        ];
        palette = [
          "0=${term0}"
          "1=${term1}"
          "2=${term2}"
          "3=${term3}"
          "4=${term4}"
          "5=${term5}"
          "6=${term6}"
          "7=${term7}"
          "8=${term8}"
          "9=${term9}"
          "10=${term10}"
          "11=${term11}"
          "12=${term12}"
          "13=${term13}"
          "14=${term14}"
          "15=${term15}"
        ];
      };
    };
  };
}

# Darwin module
# {
#   config,
#   lib,
#   pkgs,
#   ...
# }:
#
# with lib;
# let
#   cfg = config.programs.ghostty;
# in
# {
#   config = mkIf (cfg.enable && pkgs.stdenv.hostPlatform.isDarwin) {
#     programs.ghostty.package = pkgs.ghostty-bin;
#     programs.ghostty.settings.font-size = lib.mkForce 13;
#     programs.ghostty.settings.macos-option-as-alt = true;
#   };
# }
