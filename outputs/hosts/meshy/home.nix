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

    # Shell programs
    lazygit.enable = true;
    git = {
      enable = true;
      settings = {
        user.signingkey = "1C7964087CDE7E6B";
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
      enableFishIntegrationSSH = true;
      enableFishIntegration = false;
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
  };

  wayland.windowManager.hyprland.settings = {
    monitor = [
      {
        # vertical monitor (home - vic)
        output = "desc:Shenzhen KTC Technology Group H27T22C 0x00000001";
        mode = "2560x1440@180.00Hz";
        position = "0x0";
        scale = 1;
        bitdepth = 10;
        transform = 1;
      }
      {
        # horizontal monitor (home - vic)
        output = "desc:AOC Q27G40ZDF RK2S2JA008358";
        mode = "2560x1440@240.00Hz";
        position = "1440x500";
        scale = 1;
        bitdepth = 10;
      }
    ];
    workspace_rule = [
      {
        workspace = "name:permanent_ver_home_vic";
        monitor = "desc:Shenzhen KTC Technology Group H27T22C 0x00000001";
        default = true;
        layout_opts = {
          direction = "down";
          fullscreen_on_one_column = false;
        };
      }
    ]
    ++ (
      (pkgs.lib.range 1 10)
      |> (map (i: {
        workspace = i;
        monitor = "desc:AOC Q27G40ZDF RK2S2JA008358";
        default = true;
      }))
    );
  };
}
