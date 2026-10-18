{ self, inputs, ... }: {
    perSystem = { pkgs, ... }: let
        nvim-config = inputs.nvf.lib.neovimConfiguration {
            inherit pkgs;
            modules = [
                ./nvim-config.nix
            ];
        };
    in {
        packages.neovim = nvim-config.neovim;
    };

    flake.nixosModules.neovim = { pkgs, ... }: {
        programs.neovim = {
            enable = true;
            package = self.packages.${pkgs.stdenv.hostPlatform.system}.neovim;
        };
    };
}