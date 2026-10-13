{ self, inputs, ... }: {
    perSystem = { pkgs, ... }: {
        packages.noctalia = inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
            inherit pkgs;
            package = pkgs.noctalia;
            settings = 
                (builtins.fromTOML
                    (builtins.readFile ./noctalia.toml));
        };
    };
}