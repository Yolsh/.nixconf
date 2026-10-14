{ self, ... }: {
    flake.nixosModules.shell = { pkgs, ... }: let
        selfpkgs = self.packages."${pkgs.system}";
    in {
        programs = {
            fish = {
                enable = true;
                package = selfpkgs.fish;
            };

            bash.interactiveShellInit = "exec fish";

            starship = {
                enable = true;
                package = selfpkgs.starship;
            };

            zoxide.enable = true;
            bat.enable = true;

        };

        environment.systemPackages = with pkgs; [
            eza
        ];
    };
}