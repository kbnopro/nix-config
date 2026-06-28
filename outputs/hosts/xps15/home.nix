{
  pkgs,
  lib,
  ...
}:
let
  # TODO: Try again on 0.56 hyprland
  monitorScript = pkgs.writeShellApplication {
    name = "toggle-laptop-monitor";
    runtimeInputs = [
      pkgs.hyprland
    ];
    text = ''
      lidState=$(cat /proc/acpi/button/lid/LID0/state | grep -c closed)
      if [ "$lidState" -eq 1 ]; then
        hyprctl eval "hl.monitor({output = 'eDP-1', disabled = true})"
      else
        hyprctl eval "hl.monitor({output = 'eDP-1', disabled = false})"
      fi
    '';
  };
in
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
    quickshell.enable = true;

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
    awww.enable = true;
    ssh-agent.enable = true;
  };

  # wayland.windowManager.hyprland.settings = {
  #   bind = [
  #     {
  #       _args = [
  #         "switch:off:Lid Switch"
  #         (lib.generators.mkLuaInline "hl.dsp.exec_cmd('${monitorScript}/bin/toggle-laptop-monitor')")
  #       ];
  #     }
  #     {
  #       _args = [
  #         "switch:on:Lid Switch"
  #         (lib.generators.mkLuaInline "hl.dsp.exec_cmd('${monitorScript}/bin/toggle-laptop-monitor')")
  #       ];
  #     }
  #   ];
  #   on = [
  #     {
  #       _args = [
  #         "config.reloaded"
  #         (lib.generators.mkLuaInline ''
  #           function()
  #             hl.dsp.exec_cmd('${monitorScript}/bin/toggle-laptop-monitor')
  #           end
  #         '')
  #       ];
  #     }
  #   ];
  # };
}
