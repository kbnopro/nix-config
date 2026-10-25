{ nixpkgs, ghostty, ... }:

let
  overlay-versioning = final: prev: {
    microsoft-edge = prev.microsoft-edge.overrideAttrs (oa: rec {
      version = "143.0.3650.80";

      src = final.fetchurl {
        url = "https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-stable/microsoft-edge-stable_${version}-1_amd64.deb";
        hash = "sha256-Uoh3cx2Cw7Af4fNiK3sP3vpppjP0vHuMFYK8ngfQjwA=";
      };
    });

    ghostty =
      let
        noOverride = prev.lib.versionAtLeast prev.ghostty.version "1.4.0";
      in
      prev.lib.warnIf noOverride "ghostty version is already at least 1.4.0, no override needed" (
        if noOverride then prev.ghostty else ghostty.packages.${final.system}.default
      );
  };
in
[
  overlay-versioning
]
