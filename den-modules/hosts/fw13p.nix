{ config, ... }: {
  nixos.configurations.fw13p = {
    module =
      nixosArgs@{
        pkgs,
        modulesPath,
        lib,
        ...
      }:
      {
        imports =
          with config.nixos.modules;
          [
            pc
            power-management
            aagl
            unimelb-vpn
          ]
          |> lib.concat [
            (modulesPath + "/installer/scan/not-detected.nix")
            config.users.khanhbui.nixos.pc # user scope (with nixos and home-manager modules)
          ];

        system.stateVersion = "25.05";

        boot.initrd.availableKernelModules = [
          "xhci_pci"
          "thunderbolt"
          "nvme"
          "uas"
          "sd_mod"
        ];

        boot.kernelModules = [ "kvm-intel" ];
        boot.resumeDevice = "/dev/disk/by-label/NIXROOT";
        boot.kernelParams = [ "resume_offset=103385088" ];

        fileSystems."/" = {
          device = "/dev/disk/by-uuid/a9bf70d7-22ab-4e38-a8fe-4bde54b121ef";
          fsType = "ext4";
        };

        fileSystems."/boot" = {
          device = "/dev/disk/by-uuid/5C08-7BB2";
          fsType = "vfat";
          options = [
            "fmask=0022"
            "dmask=0022"
          ];
        };

        swapDevices = [
          {
            device = "/.swapfile";
            size = 32 * 1024;
          }
        ];

        hardware.cpu.intel.npu.enable = true;
        hardware.cpu.intel.updateMicrocode = lib.mkDefault nixosArgs.config.hardware.enableRedistributableFirmware;

        boot.loader.systemd-boot.windows."11" = {
          title = "Windows 11";
          efiDeviceHandle = "HD0b";
        };

        boot.loader.systemd-boot.enable = true;
        boot.loader.efi.canTouchEfiVariables = true;
        boot.loader.systemd-boot.configurationLimit = 5;
        boot.loader.systemd-boot.consoleMode = "0";
        boot.kernelPackages = pkgs.linuxPackages_latest;

        services.openssh.publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID/jbAbzYqoFva8TUw8A27v0Tbe/GGImQriaKo/CcQ0h root@kb-fw13p";
      };
  };
}
