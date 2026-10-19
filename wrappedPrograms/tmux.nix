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
        baketop = 3;
        prefix = "C-s";
        configBefore = ''
            set -g status-position top
            set -g @tmux-gruvbox 'dark'
        '';
        plugins = with pkgs; [
            tmuxPlugins.gruvbox
        ];
    };
}