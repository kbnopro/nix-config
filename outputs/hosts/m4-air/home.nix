{
  pkgs,
  lib,
  ...
}:
{
  home = {
    username = "khanhbui";
    homeDirectory = lib.mkForce "/Users/khanhbui";
    stateVersion = "25.05";
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    packages = with pkgs; [
      nerd-fonts.space-mono
    ];
  };

  programs = {
    # GUI programs
    ghostty.enable = true;

    # Apps programs
    discord.enable = true;
    spicetify.enable = true;

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
}
