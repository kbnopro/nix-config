{
  pkgs,
  ...
}:
{
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
    firefox.enable = true;
    discord.enable = true;
    zathura.enable = true;
    spicetify.enable = true;

    # Uni apps
    # rstudio.enable = true;
    # intellij.enable = true;

    # TUI programs
    starship = {
      enable = true;
      enableFishIntegration = true;
    };
    btop = {
      enable = true;
      enableNvidia = true;
    };

    # Shell programs
    lazygit.enable = true;
    git = {
      enable = true;
      settings = {
        user.signingkey = "3C16B9C5884214F1";
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
    awww.enable = true;
    ssh-agent.enable = true;
    gpg-agent = {
      enable = true;
      enableFishIntegration = true;
    };
    easyeffects = {
      enable = true;
    };
  };

  wayland.windowManager.hyprland.settings = {
    monitor = [
      {
        output = "eDP-1";
        mode = "2880x1920@120.00000";
        position = "0x0";
        scale = 1.5;
        bitdepth = 10;
        # TODO: Wait for firmware update to fix vrr issue
        vrr = 0;
      }
    ];
  };
}
