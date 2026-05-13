{
  description = "Assets collection for NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      lib = nixpkgs.lib;
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      foreachSystem = f: lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
    in
    {
      packages = foreachSystem (pkgs: {
        default = pkgs.callPackage ./nix/default.nix { };
      });

      checks = foreachSystem (pkgs: {
        validate-assets = pkgs.callPackage ./nix/checks.nix {
          assetsPkg = self.packages.${pkgs.stdenv.hostPlatform.system}.default;
        };
      });

      nixosModules.default = import ./nix/module.nix self;
      homeManagerModules.default = import ./nix/module.nix self;
    };
}
