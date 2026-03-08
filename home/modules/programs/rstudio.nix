{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.programs.rstudio;

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
  options.programs.rstudio = {
    enable = lib.mkEnableOption "RStudio IDE";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      rEnv
      rStudio
    ];
  };
}
