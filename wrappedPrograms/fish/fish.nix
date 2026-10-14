{ self, inputs, ... }: {
    perSystem = { pkgs, ... }: {
        packages.fish = inputs.wrapper-modules.wrappers.fish.wrap {
            inherit pkgs;
            imports = [ self.wrappersModules.fish ];
        };
    };

    flake.nixosModules.fish = { pkgs, lib, ... }: {
        programs.fish = {
            enable = true;
            package = self.packages.${pkgs.stdenv.hostPlatform.system}.fish;
        };
    };

    flake.wrappersModules.fish = {
        configFile.content = (builtins.readFile ./config.fish); # needs to be linked in as terminal package
    };
}