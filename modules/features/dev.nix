{ self, ... }: {
    flake.nixosModules.dev = {
        environment.systemPackages = with pkgs; [
            devenv
            git
        ];
    };
}