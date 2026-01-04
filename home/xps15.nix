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
    packages = with pkgs; [
      customNeovim.neovim
      nerd-fonts.space-mono
      gnome-control-center
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
