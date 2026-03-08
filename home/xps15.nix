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
      blueberry
    ];
  };

  programs = {
    # Temporary programs (ideally, all configs should be moved to designated folder)
    fish = {
      enable = true;
      loginShellInit = ''
        if uwsm check may-start
          exec uwsm start hyprland-uwsm.desktop 
        end
      '';
    };

    # GUI programs
    # foot.enable = true;
    ghostty.enable = true;
    fuzzel.enable = true;

    # Apps programs
    edge.enable = true;
    discord.enable = true;
    zathura.enable = true;
    spicetify.enable = true;
    rstudio.enable = true;

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

  wayland.windowManager.hyprland = {
    enable = true;
  };

  services = {
    swww.enable = true;
  };

}
