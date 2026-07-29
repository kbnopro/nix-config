{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.ddcutil;
in
{
  options = {
    programs.ddcutil = {
      enable = lib.mkEnableOption "Enable ddcutil for controlling monitor settings.";
    };
  };
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      ddcutil
    ];
    hardware.i2c.enable = true;
  };
}
