{ lib, config, ... }:
{
  nixos.modules.base = {
    options.services.openssh.publicKey = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
    };

    config = {
      networking.firewall.enable = true;
      services.openssh = {
        enable = true;
        # We have tailscale for this
        openFirewall = false;

        settings = {
          PasswordAuthentication = false;
        };
      };

      # From https://github.com/mightyiam/infra/blob/f971d0d2cea8da721b9de0f820e5db9c949035a7/modules/ssh.nix#L8
      # Snippet to generate known_hosts entries
      programs.ssh.knownHosts =
        config.nixos.configurations
        |> lib.filterAttrs (
          _name: { configuration, ... }: lib.isString configuration.config.services.openssh.publicKey
        )
        |> lib.mapAttrs (
          _name: { configuration, ... }: {
            hostNames = [ "${configuration.config.networking.hostName}.local" ];
            inherit (configuration.config.services.openssh) publicKey;
          }
        );
    };
  };
}
