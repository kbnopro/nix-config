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
      pkgs.vpnc-scripts
    ];
    # sudo -E to resolve default browser
    # hip cause the vpn ask for it
    # script to fix vpnc path resolve
    text = ''
      sudo -E gpclient --fix-openssl connect --hip --browser default \
      --script ${pkgs.vpnc-scripts}/bin/vpnc-script vpn.unimelb.edu.au
    '';
  };
in
{
  options = {
    programs.unimelb-vpn.enable = lib.mkEnableOption "Enable unimelb-vpn service";
  };
  config = lib.mkIf cfg.enable {
    # /etc/resolv.conf is read-only, so need resolved to sit in front
    services.resolved.enable = true;
    environment.systemPackages = [
      # Commands should be available to user shell for browser to call
      inputs.globalprotect-openconnect.packages.${currentSystem}.default
      unimelbVpn
    ];
  };
}
