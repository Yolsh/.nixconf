{ self, inputs, ... }: {
    perSystem = { pkgs, ... }: {
        packages.ghostty = inputs.wrapper-modules.wrappers.ghostty.wrap {
            inherit pkgs;
            imports = [ self.wrappersModules.ghostty ];
        };
    };

    flake.nixosModules.ghostty = { pkgs, lib, ... }: {
        programs.ghostty = {
            enable = true;
            package = self.packages.${pkgs.stdenv.hostPlatform.system}.ghostty;
        };
    };

    flake.wrappersModules.ghostty = {
        settings = {
            font-family = "JetBrainsMono Nerd Font";
            theme = "Gruvbox Dark";
            # command = set this as /bin/bash but need to link in nix store
        };
    };
}