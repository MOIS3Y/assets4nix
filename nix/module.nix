self:
{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  cfg = config.assets;

  # Get the package for the current system
  assetsPkg = self.packages.${pkgs.system}.default or self.packages.x86_64-linux.default;

  # Build the asset tree using the shared library logic
  allAssets = import ./lib.nix { inherit lib assetsPkg; };
in
{
  options.assets = {
    enable = lib.mkEnableOption "assets4nix" // {
      default = true;
    };
  };

  config = mkIf cfg.enable {
    # Expose the tree in lib.assets for general use
    lib.assets = allAssets;

    # Inject assets as a module argument for ergonomic access ({ assets, ... }:)
    _module.args.assets = allAssets;
  };
}
