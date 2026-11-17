{ ... }: {
  nixos.modules.base =
    nixosArgs:
    let
      wifiBackend = nixosArgs.config.services.connman.wifi.backend;
    in
    {
      services.tailscale = {
        enable = true;
        openFirewall = true;
      };
      systemd.services.tailscaled = {
        after = [ "${wifiBackend}.service" ];
      };
    };
}
