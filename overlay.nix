{ nixpkgs, ... }:

let
  overlay-versioning = final: prev: {
    nil = prev.nil.overrideAttrs (oa: rec {
      pname = "nil";

      src = final.fetchFromGitHub {
        owner = "oxalica";
        repo = pname;
        rev = "52304da8e9748feff559ec90cb1f4873eda5cee1";
        hash = "sha256-MfSA8T+4q/FzQVg7gSy4AG7EdVgZ1qt11n7Q8o30uWA=";
      };

      cargoDeps = final.rustPlatform.fetchCargoVendor {
        inherit src;
        hash = "sha256-Ggr9/wq4fitlLUrZNRVYJKFLSWjFPcHRXXtAElSo5RU=";
      };
    });
  };
in
[
  overlay-versioning
]
