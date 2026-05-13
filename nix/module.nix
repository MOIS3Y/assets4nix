self:
{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkOption types;
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
  } // (lib.mapAttrs (name: _: mkOption {
    type = types.anything;
    readOnly = true;
    description = "Asset paths for ${name}";
  }) allAssets);

  config = mkIf cfg.enable {
    # Also make them available under config.assets
    assets = allAssets;

    # Inject assets as a module argument for ergonomic access ({ assets, ... }:)
    _module.args.assets = allAssets;
  };
}
