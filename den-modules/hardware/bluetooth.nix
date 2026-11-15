{ lib, ... }: {
  nixos.modules.pc =
    nixosArgs@{ pkgs, ... }:
    {
      hardware.bluetooth.enable = lib.mkDefault true;
      environment.systemPackages = lib.mkIf nixosArgs.config.hardware.bluetooth.enable [ pkgs.bluetui ];
    };
}
