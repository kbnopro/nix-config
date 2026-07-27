{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.programs.unimelb-vpn;

  currentSystem = pkgs.stdenv.hostPlatform.system;

  unimelbVpn = pkgs.writeShellApplication {
    name = "unimelb-vpn";
    runtimeInputs = [
      inputs.globalprotect-openconnect.packages.${currentSystem}.default
    ];
    text = ''
      sudo -E gpclient --fix-openssl connect --browser default vpn.unimelb.edu.au
    '';
  };
in
{
  options = {
    programs.unimelb-vpn.enable = lib.mkEnableOption "Enable unimelb-vpn service";
  };
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      inputs.globalprotect-openconnect.packages.${currentSystem}.default
      unimelbVpn
    ];
  };
}
