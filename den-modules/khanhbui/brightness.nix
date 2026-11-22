{
  users.khanhbui.nixos.pc =
    _nixosArgs@{ pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        brightnessctl
        ddcutil
      ];
      hardware.i2c.enable = true;
    };
}
