{ self, inputs, ... }: {
    perSystem = { pkgs, ... }: let
        nvim-config = inputs.nvf.lib.neovimConfiguration {
            inherit pkgs;
            modules = [
                ./_nvim-config.nix
            ];
        };
    in {
        packages.neovim = nvim-config.neovim;
    };

    flake.nixosModules.neovim = { pkgs, ... }: {
        environment.systemPackages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.neovim ];
    };

    flake.nixosConfigurations.neovim = {
        programs.nvf = {
            enable = true;
        };
    };
}