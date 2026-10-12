{
    flake.nixosModules.hostLambda = { config, lib, pkgs, modulesPath, ... }: {
        imports = [
            (modulesPath + "/installer/scan/not-detected.nix")
        ];
        boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "wl" ];
        boot.initrd.kernelModules = [ ];
        boot.kernelModules = [ "kvm-intel" ];
        boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];

        nixpkgs.config.allowInsecurePredicate = pkg: builtins.elem (lib.getName pkg) [ "broadcom-sta" ];
        boot.blacklistedKernelModules = [ "b43" "bcma" "ssb" "brcmsmac" ];
        boot.initrd.systemd.supressedUnits = [ "systemd-machine-id-commit.service" ];
        systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];
        

        swapDevices = [ ];

        nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
        hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
}
