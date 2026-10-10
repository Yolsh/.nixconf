{
    flake.nixosModules.hostLambda = { config, lib, pkgs, modulesPath, ... }: {
        imports = [
            (modulesPath + "/installer/scan/not-detected.nix")
        ];
        boot.initrd.availableKernelModules = [ "xhci_pci" "uas" "sd_mod" "sdhci_pci" ];
        boot.initrd.kernelModules = [ ];
        boot.kernelModules = [ "kvm-intel" ];
        boot.extraModulePackages = [ ];

        fileSystems."/" = {
            device = "/dev/disk/by-uuid/285d42dd-4d4a-4a51-9720-3a159be18526";
            fsType = "btrfs";
        };

        fileSystems."/home" = {
            device = "/dev/disk/by-uuid/285d42dd-4d4a-4a51-9720-3a159be18526";
            fsType = "btrfs";
            options = [ "subvol=home" ];
        };

        fileSystems."/nix" = {
            device = "/dev/disk/by-uuid/285d42dd-4d4a-4a51-9720-3a159be18526";
            fsType = "btrfs";
            options = [ "subvol=nix" ];
        };

        fileSystems."/boot" = {
            device = "/dev/disk/by-uuid/2357-B6D3";
            fsType = "vfat";
            options = [ "fmask=0077" "dmask=0077" ];
        };

        swapDevices = [ ];

        nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
        hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
}
