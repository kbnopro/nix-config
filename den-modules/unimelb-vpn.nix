{ inputs, lib, ... }: {
  options = {
    nixos.modules.unimelb-vpn = lib.mkOption {
      type = lib.types.deferredModule;
      apply = module: {
        key = "unimelb-vpn";
        imports = [ module ];
      };
    };
  };

  config = {
    nixos.modules.unimelb-vpn =
      _nixosArgs@{
        pkgs,
        ...
      }:
      let
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
            sudo -E gpclient --fix-openssl connect \
            --hip \
            --browser default \
            --script ${pkgs.vpnc-scripts}/bin/vpnc-script \
            vpn.unimelb.edu.au
          '';
        };
      in
      {
        services.resolved.enable = true;
        environment.systemPackages = [
          inputs.globalprotect-openconnect.packages.${currentSystem}.default
          unimelbVpn
        ];
      };
  };
}
