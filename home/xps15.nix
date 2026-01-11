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
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    packages = with pkgs; [
      customNeovim.neovim
      nerd-fonts.space-mono
      gnome-control-center
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

    git = {
      enable = true;
      settings = {
        user.name = "kbnopro";
        user.email = "tuankhanhb00@gmail.com";
      };
    };

    # GUI programs
    # foot.enable = true;
    ghostty.enable = true;
    fuzzel.enable = true;

    # Apps programs
    edge.enable = true;
    discord.enable = true;
    zathura.enable = true;

    # TUI programs
    starship = {
      enable = true;
      enableFishIntegration = true;
    };

    lazygit.enable = true;

    # Shell programs
    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

    zellij = {
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
