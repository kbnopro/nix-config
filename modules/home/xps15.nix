{
  pkgs,
  ...
}:
{
  imports = [ ./modules ];

  home = {
    username = "khanhbui";
    homeDirectory = "/home/khanhbui";
    stateVersion = "25.05";
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    packages = with pkgs; [
      nerd-fonts.space-mono
      gnome-control-center
      blueman
    ];
  };

  programs = {
    # GUI programs
    # foot.enable = true;
    ghostty.enable = true;
    fuzzel.enable = true;

    # Apps programs
    edge.enable = true;
    discord.enable = true;
    zathura.enable = true;
    spicetify.enable = true;
    # Uni apps, might vary a lot
    rstudio.enable = true;
    intellij.enable = true;

    # TUI programs
    starship = {
      enable = true;
      enableFishIntegration = true;
    };

    lazygit.enable = true;

    # Shell programs
    git.enable = true;
    gh.enable = true;
    nvf.enable = true;
    fish.enable = true;

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

    zellij = {
      enable = true;
      enableFishIntegration = true;
    };

    direnv = {
      enable = true;
      enableFishIntegration = true;
    };
  };

  services = {
    swww.enable = true;
  };

}
