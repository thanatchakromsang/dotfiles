# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" "sdhci_pci" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ pkgs.linuxKernel.packages.linux_5_15.hid-nintendo  ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/3eaac046-253a-4f1e-baab-9047725a812f";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/E782-A028";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/11678589-7553-4545-b7d7-5724db20051a"; }
    ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
