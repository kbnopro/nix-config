{
  config,
  lib,
  ...
}:

with lib;
let
  cfg = config.programs.ghostty;
  colors = config.background.colors;
in
{
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
      bind = [
        "SUPER, T, exec, ghostty +new-window"
      ];
    };
    programs.ghostty = with colors.withHashtag; {
      settings = {
        background = surface;
        foreground = onSurface;
        background-opacity = colors.opacity;
        font-size = 10;
        window-padding-x = 16;
        window-padding-y = 16;
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
