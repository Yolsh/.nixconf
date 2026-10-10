{self, inputs, ... }: {
    flake.nixosConfigurations.lambda = inputs.nixpkgs.lib.nixosSystem {
        modules = [
            self.nixosModules.hostLambda
        ];
    };

    flake.nixosModules.hostLambda = { config, pkgs, ... }: {
        imports = [
            self.nixosModules.desktop
        ];

        # Use the systemd-boot EFI boot loader.
        boot.loader.systemd-boot.enable = true;
        boot.loader.efi.canTouchEfiVariables = true;
        boot.blacklistedKernelModules = [ "elan_i2c" ];

        networking.hostName = "nixos";
        # networking.wireless.enable = true;
        networking.networkmanager.enable = true;

        services.displayManager.gdm.enable = true;
        services.desktopManager.gnome.enable = true;

        services.xserver.xkb = {
            layout = "gb";
            variant = "";
        };
        console.keyMap = "uk";
        services.printing.enable = true;

        services.pulseaudio.enable = false;
        security.rtkit.enable = true;
        services.pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
            # If you want to use JACK applications, uncomment this
            # jack.enable = true;
        };

        # Enable touchpad support (enabled default in most desktopManager).
        # services.libinput.enable = true;

        users.users."yolsh" = {
            isNormalUser = true;
            description = "Josh";
            extraGroups = [ "networkmanager" "wheel" ];
            packages = with pkgs; [
                ghostty
            ];
        };

        programs = {
            firefox.enable = true;
            vscode = {
                enable = true;
                extensions = with pkgs.vscode-extensions; [
                    bbenoist.nix
                    ms-python.python
                ];
            };
        };

        nixpkgs.config.allowUnfree = true;

        environment.systemPackages = with pkgs; [
            wget
            git
            (python3.withPackages(pypkgs: with pypkgs; [
                beautifulsoup4
                cryptography
                pillow
            ]))
        ];
        
        nix.settings.experimental-features = [ "nix-command" "flakes" ];

        system.stateVersion = "26.05"; # DO NOT CHANGE!!!

    };
}
