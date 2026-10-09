{ config, ... }:
let
  wifiBackend = config.services.connman.wifi.backend;
in
{
  services.tailscale = {
    openFirewall = true;
  };
  systemd.services.tailscaled = {
    after = [ "${wifiBackend}.service" ];
  };
}
