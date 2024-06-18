# ▄▀█ █▀ █▀ █▀▀ ▀█▀ █▀  █░█  █▄░█ █ ▀▄▀ ▀
# █▀█ ▄█ ▄█ ██▄ ░█░ ▄█  ▀▀█  █░▀█ █ █░█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- --

{
  description = ''
    Assets collection (icons, wallpapers, styles, etc)
    for declarative NixOS configuration
  '';

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }@inputs:
  let
    lib = nixpkgs.lib;
    genSystems = lib.genAttrs [
      "aarch64-linux"
      "x86_64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];
    pkgsFor = genSystems (system:
      import nixpkgs {
        inherit system;
        overlays = [ self.overlays.assets4nix ];
      }
    );
  in {
    packages = genSystems (system:
      (self.overlays.default pkgsFor.${system} pkgsFor.${system})
      // { default = self.packages.${system}.assets4nix; }
    );
    overlays = (import ./nix/overlays.nix { })
    // { default = self.overlays.assets4nix ; };
  };
}
