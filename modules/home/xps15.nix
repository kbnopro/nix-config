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
    # quickshell.enable = true;

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

    # Shell programs
    lazygit.enable = true;
    git = {
      enable = true;
      settings = {
        user.signingkey = "230413BD8EA1E853";
        commit.gpgsign = true;
      };
    };
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

    # Gpg
    gpg.enable = true;
  };

  services = {
    swww.enable = true;
    ssh-agent.enable = true;
  };

}
