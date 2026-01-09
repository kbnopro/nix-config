{
  config,
  lib,
  ...
}:

with lib;
let
  cfg = config.programs.ghostty;
  color = config.background.color;
  trimTerm =
    string:
    if builtins.substring 0 4 string == "term" then
      builtins.substring 4 (builtins.stringLength string) string
    else
      string;
in
{
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
      bind = [
        "SUPER, T, exec, ghostty"
      ];
    };
    programs.ghostty = {
      settings = {
        background = color.surface;
        foreground = color.onSurface;
        background-opacity = 0.90;
        font-size = 10;
        window-padding-x = 20;
        window-padding-y = 20;
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
          "0=${trimTerm color.term0}"
          "1=${trimTerm color.term1}"
          "2=${trimTerm color.term2}"
          "3=${trimTerm color.term3}"
          "4=${trimTerm color.term4}"
          "5=${trimTerm color.term5}"
          "6=${trimTerm color.term6}"
          "7=${trimTerm color.term7}"
          "8=${trimTerm color.term8}"
          "9=${trimTerm color.term9}"
          "10=${trimTerm color.term10}"
          "11=${trimTerm color.term11}"
          "12=${trimTerm color.term12}"
          "13=${trimTerm color.term13}"
          "14=${trimTerm color.term14}"
          "15=${trimTerm color.term15}"
        ];
      };
    };
  };
}
