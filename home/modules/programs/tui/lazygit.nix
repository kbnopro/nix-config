{
  config,
  lib,
  ...
}:
let
  colors = config.background.colors;
  # Lazygit seems to use a mixture of self config + color from the terminal
  cfg = config.programs.lazygit;
in
{
  config = lib.mkIf cfg.enable {
    home.shellAliases.lazygit = "lg";
    programs.lazygit = {
      settings = {
        gui.theme = with colors.withHashtag; {
          activeBorderColor = [
            "${primary}"
            "bold"
          ];
          inactiveBorderColor = [
            "${onSurface}"
          ];
          selectedLineBgColor = [
            "${secondaryContainer}"
          ];
          searchingActiveBorderColor = [
            "${term6}" # cyan
            "bold"
          ];
          optionsTextColor = [
            "${term4}" # blue
          ];
          cherryPickedCommitFgColor = [
            "${onPrimaryContainer}"
          ];
          cherryPickedCommitBgColor = [
            "${primaryContainer}"
          ];
        };
      };
    };

  };
}
