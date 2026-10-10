{ self, inputs, ... }: {
    perSystem = { pkgs, ... }: {
        packages.noctalia = inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
            inherit pkgs;
            package = pkgs.noctalia;
            env = {
                "NOCTALIA_CACHE_DIR" = "/tmp/noctalia-cache/";
            };
            outOfStoreConfig = "/tmp/noctalia-config";
            settings = 
                (builtins.fromTOML
                    (builtins.readFile ./noctalia.toml));
        };
    };
}