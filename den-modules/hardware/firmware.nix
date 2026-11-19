{
  nixos.modules.base = {
    services.fwupd.enable = true;
    hardware.enableAllFirmware = true;
  };
  perSystem = {
    nixpkgs.config.allowUnfreePackages = [
      "b43-firmware"
      "facetimehd-calibration"
      "broadcom-bt-firmware"
      "xone-dongle-firmware"
      "facetimehd-firmware"
    ];
  };
}
