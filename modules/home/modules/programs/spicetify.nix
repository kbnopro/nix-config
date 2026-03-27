{
  pkgs,
  inputs,
  config,
  lib,
  ...
}:
let
  cfg = config.programs.spicetify;

  # Original starry night
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};

  colors = config.background.colors;

  spiceOverrideColor = pkgs.writeTextFile {
    name = "color.ini";
    destination = "/color.ini";
    text = with colors; ''
      [Base]
      star                    = FFFFFF
      star-glow               = FFFFFF
      shooting-star           = FFFFFF
      shooting-star-glow      = FFFFFF

      main                    = 000000 ; becomes 100% transparent via javascript
      main-elevated           = ${surfaceContainerHigh}
      card                    = ${surfaceContainerHigh}

      sidebar                 = ${surfaceContainerHighest}" ; bottom part of sky
      sidebar-alt             = ${surfaceContainerLowest} ; top part of sky

      text                    = ${onSurface}
      subtext                 = ${onSurfaceVariant}

      button-active           = ${primary}
      button                  = ${primary}
      button-disabled         = 000000

      highlight               = 191919
      highlight-elevated      = 152238 

      shadow                  = ${shadow}
      selected-row            = FFFFFF
      misc                    = 7F7F7F
      notification-error      = E22134 
      notification            = 4687d6
      tab-active              = 333333
      player                  = 181818
    '';
  };

  spiceCustomTheme = pkgs.runCommand "theme" { } ''
    mkdir $out
    cp -r ${spicePkgs.themes.starryNight.src}/* $out/
    rm $out/color.ini
    cp -r ${spiceOverrideColor}/* $out/
  '';

  # spiceCustomTheme = spicePkgs.themes.starryNight.src;

in
{
  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      wayland.windowManager.hyprland.settings.windowrule = [
        "opacity ${builtins.toString colors.opacity}, match:class spotify"
      ];
    })
    {
      programs.spicetify = {
        # theme = spicePkgs.themes.starryNight;
        theme = spicePkgs.themes.starryNight // {
          name = "stylix";
          src = spiceCustomTheme;
        };
        colorScheme = "Base";
      };
    }
  ];
}
