{
  config,
  lib,
  ...
}:
let
  color = config.background.color;
  # Lazygit seems to use a mixture of self config + color from the terminal
  cfg = config.programs.lazygit;
in
{
  config = lib.mkIf cfg.enable {
    home.shellAliases.lazygit = "lg";
    programs.lazygit = {
      settings = {
        gui.theme = {
          activeBorderColor = [
            "${color.primary}"
            "bold"
          ];
          inactiveBorderColor = [
            "${color.onSurface}"
          ];
          selectedLineBgColor = [
            "${color.secondaryContainer}"
          ];
          searchingActiveBorderColor = [
            "${color.term6}" # cyan
            "bold"
          ];
          optionsTextColor = [
            "${color.term4}" # blue
          ];
          cherryPickedCommitFgColor = [
            "${color.onPrimaryContainer}"
          ];
          cherryPickedCommitBgColor = [
            "${color.primaryContainer}"
          ];
        };
      };
    };

  };
}
