{ pkgs, inputs, ...}:
let 
  # nvf stuffs
  customNeovim = inputs.nvf.lib.neovimConfiguration {
    inherit pkgs;
    modules = [
      ../nvf/xps15.nix
    ];
  };

in
  {
  imports = [
    ./modules/programs
    ./modules/git
    ./modules/hyprland
  ];

  home = {
    username = "khanhbui";
    homeDirectory = "/home/khanhbui";
    stateVersion = "25.05";
    packages = [customNeovim.neovim];
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

    edge.enable = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
  };

}
