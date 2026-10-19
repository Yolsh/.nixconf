{ self, inputs, ... }: {
    perSystem = { pkgs, ... }: {
        packages.tmux = inputs.wrapper-modules.wrappers.tmux.wrap {
            inherit pkgs;
            imports = [ self.wrappersModules.tmux ];
        };
    };

    flake.nixosModules.tmux = { pkgs, ... }: {
        programs.tmux = {
            enable = true;
            package = self.packages.${pkgs.stdenv.hostPlatform.system}.tmux;
        };
    };

    flake.wrappersModules.tmux = { pkgs, ... }: {
        baseIndex = 1;
        prefix = "C-s";
        shell = self.packages.${pkgs.stdenv.hostPlatform.system}.fish;
    };
}