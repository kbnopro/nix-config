{
  nixos.modules.base = {
    services.fwupd.enable = true;
    hardware.enableAllFirmware = true;
  };
}
