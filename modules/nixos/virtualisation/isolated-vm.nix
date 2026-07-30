{ config, lib, ... }:
let
  cfg = config.virtualisation.isolated-vm;
in
{
  options = {
    virtualisation.isolated-vm = {
      enable = lib.mkEnableOption "Enable isolated VM support";
      user = lib.mkOption {
        type = lib.types.str;
        default = "isolated-vm";
        description = "The user allowed to access the isolated VM";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    users.users.${cfg.user} = {
      extraGroups = [ "libvirtd" ];
    };

    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;
  };
}
