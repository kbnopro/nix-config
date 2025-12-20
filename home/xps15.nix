{
  pkgs,
  inputs,
  mylib,
  config,
  ...
}:
let
  color = config.background.color;

  # nvf stuffs
  customNeovim = inputs.nvf.lib.neovimConfiguration {
    inherit pkgs;
    modules = [
      ../nvf/xps15.nix
    ];
    extraSpecialArgs = {
      inherit mylib color;
    };
  };

in
{
  imports = [ ./modules ];

  home = {
    username = "khanhbui";
    homeDirectory = "/home/khanhbui";
    stateVersion = "25.05";
    packages = [
      customNeovim.neovim
      pkgs.nerd-fonts.space-mono

    ];
  };

  programs = {
    fish = {
      enable = true;
      loginShellInit = ''
        if uwsm check may-start
          exec uwsm start hyprland-uwsm.desktop 
        end
      '';
    };

    git = {
      enable = true;
      settings = {
        user.name = "kbnopro";
        user.email = "tuankhanhb00@gmail.com";
      };
    };

    foot = {
      enable = true;
      settings = {
        main = {
          term = "xterm-256color";
          font = "SpaceMono Nerd Font:size=7";
          dpi-aware = "yes";
        };

        colors = {
          alpha = 0.90;
        };
      };

    };

    starship = {
      enable = true;
      enableFishIntegration = true;
    };

    edge.enable = true;

    discord.enable = true;

    fuzzel.enable = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
  };

  services = {
    swww.enable = true;
  };

}
