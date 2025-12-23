{
  config,
  ...
}:
let
  color = config.background.color;
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
