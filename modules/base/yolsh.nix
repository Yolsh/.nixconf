{ self, inputs, ... }: {
    flake.nixosModules.yolsh = { pkgs, config, ... }: {
        imports = [
            inputs.hjem.nixosModules.default
        ];

        users.users."yolsh" = {
            isNormalUser = true;
            description = "Josh";
            hashedPasswordFile = "/persistent/passwd";
            extraGroups = [ "networkmanager" "wheel" ];
        };

        hjem = {
            extraModules = [
                inputs.hjem-rum.hjemModules.default
            ];

            users.yolsh = {
                directory = "/home/yolsh";
                user = "yolsh";

                rum = {
                    programs = {
                        git = {
                            enable = true;
                            settings.user = {
                                email = "joshapplebysmith@gmail.com";
                                name = "yolsh";
                            };
                        };
                    };
                };
            };
            clobberByDefault = true;
        };
    };
}