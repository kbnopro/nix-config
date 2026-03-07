{ pkgs, ... }:
let
  rPkgs = with pkgs.rPackages; [
    knitr
    htmltools
    jsonlite
    magrittr
    mime
    rmarkdown
    stringi
    stringr
  ];

  rEnv = pkgs.rWrapper.override {
    packages = rPkgs;
  };

  rStudio = pkgs.rstudioWrapper.override {
    packages = rPkgs;
  };
in
{
  home.packages = [
    rEnv
    rStudio
  ];
}
