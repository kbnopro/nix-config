{ lib, ... }: {
  users.khanhbui.home.base =
    hmArgs:
    let
      # Lazygit seems to use a mixture of self config + color from the terminal
      colors = hmArgs.config.background.colors;
    in
    {
      home.shellAliases.lazygit = "lg";
      programs.lazygit = {
        enable = true;
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

      programs.git = {
        enable = true;
        settings = {
          user.name = lib.mkDefault "kbnopro";
          user.email = lib.mkDefault "tuankhanhb00@gmail.com";
          commit.gpgsign = true;
        };
      };
    };
}
