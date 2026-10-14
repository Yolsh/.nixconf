{ self, ... }: {
    flake.nixosModules.dev = { pkgs, ... }: {
        environment.systemPackages = with pkgs; [
            devenv
            git
            github-cli
        ];
    };
}