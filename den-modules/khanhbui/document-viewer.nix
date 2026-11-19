{ lib, ... }: {
  users.khanhbui.home.gui = hmArgs: {
    programs.zathura = {
      enable = true;
      options = {
        selection-clipboard = "clipboard";
      };
    };
    xdg.mimeApps.defaultApplicationPackages = lib.mkOrder 15 [ hmArgs.config.programs.zathura.package ];
  };
}
