{
    flake.nixosModules.hostLambda = { config, lib, pkgs, modulesPath, ... }: {
        imports = [
            (modulesPath + "/installer/scan/not-detected.nix")
        ];
        boot.initrd.availableKernelModules = [ "xhci_pci" "uas" "sd_mod" "sdhci_pci" ];
        boot.initrd.kernelModules = [ ];
        boot.kernelModules = [ "kvm-intel" ];
        boot.extraModulePackages = [ ];

        swapDevices = [ ];

        nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
        hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
}
