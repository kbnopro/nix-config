{
  config,
  ...
}:
let
  color = config.background.color;
  # Lazygit seems to use a mixture of self config + color from the terminal
in
{
  programs.lazygit = {
    enable = true;
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
        # doesn't seem to work
        # markedBaseCommitFgColor = [
        #   "red"
        # ];
        # markedBaseCommitBgColor = [
        #   "red"
        # ];
      };
    };
  };
}
