{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.services.tpm-fido;

  linux-id =
    with pkgs;
    buildGoModule {
      pname = "linux-id";
      version = "0.2.0";

      src = fetchFromGitHub {
        owner = "kbnopro";
        repo = "linux-id";
        rev = "7e74316da0988e5956e44a7f7adab2e63b78c569";
        hash = "sha256-Ojm2c1aYrvhus0t24uxfI60W/nQxiwJ4lFTG8a1Gf/I=";
      };

      vendorHash = "sha256-HwLcsjzaFqc0aQrTCoSUdes6ZlnsNZJCdtjwucFyOQ4=";

      ldFlags = [
        "-s "
        "-w"
      ];
    };
in
{
  options.services.tpm-fido = {
    enable = lib.mkEnableOption "Enable tpm fido";
    user = lib.mkOption {
      type = lib.types.str;
      default = "khanhbui";
      description = "User to run linux-id as. Can not be root.";
    };
  };

  config = lib.mkIf cfg.enable {
    # Enable fprintd for fingerprint authentication
    services.fprintd.enable = true;

    # Permissions for TPM and FIDO2 devices
    security.tpm2 = {
      enable = true;
      tssGroup = "tss";
    };

    users.groups.uhid.name = "uhid";
    systemd.tmpfiles.rules = [
      "z /dev/uhid 0660 root uhid - -"
    ];

    users.users.${cfg.user} = {
      extraGroups = [
        "tss" # Allow using TPM
        "uhid" # Allow using FIDO2 devices
      ];
    };

    systemd.user.services.tpm-fido = {
      description = "TPM-backed FIDO Token";

      # Only start once the graphical session (and pinentry capability) is ready
      after = [ "graphical-session.target" ];
      wantedBy = [ "graphical-session.target" ];

      serviceConfig = {
        ExecStart = "${linux-id}/bin/linux-id --auth fprintd";
        Restart = "always";
        RestartSec = "3";
        # Requirement: tpm-fido needs pinentry to verify user presence
        Environment = "PATH=${
          lib.makeBinPath [
            pkgs.pinentry-qt
          ]
        }";
      };
    };
  };
}
