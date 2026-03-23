{
  pkgs,
  lib,
  ...
}:
{
  imports = [ ./modules ];

  home = {
    username = "khanhbui";
    homeDirectory = lib.mkForce "/Users/theatran";
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
    alacritty.enable = true;

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
