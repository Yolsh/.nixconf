{
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        flake-parts.url = "github:hercules-ci/flake-parts";
        import-tree.url = "github:vic/import-tree";
        
        wrappers.url = "github:Lassulus/wrappers";
        wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";

        disko = {
            url = "github:nix-community/disko";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        impermanence = {
            url = "github:nix-community/impermanence";
            inputs.nixpkgs.follows = "";
            inputs.home-manager.follows = "";
        };

        zen-browser = {
            url = "github:0xc000022070/zen-browser-flake";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        nvf = {
            url = "github:notashelf/nvf";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = inputs: let
        inherit (inputs.nixpkgs) lib;
        inherit (lib.fileset) toList fileFilter;

        isNixModule = file:
            file.hasExt "nix"
            && file.name != "flake.nix"
            && !lib.hasPrefix "_" file.name;
        
        importTree = path:
            toList (fileFilter isNixModule path);
        
        mkFlake = inputs.flake-parts.lib.mkFlake {inherit inputs;};
    in
        mkFlake {imports = importTree ./.;};
}
