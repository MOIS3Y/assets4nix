{
  lib,
  pkgs,
  assetsPkg,
}:
let
  # Import the asset tree for validation
  assets = import ./lib.nix { inherit lib assetsPkg; };
in
# Validation check: verify that specific assets are accessible and exist
pkgs.runCommand "validate-assets"
  {
    nativeBuildInputs = [ pkgs.coreutils ];
  }
  ''
    echo "Checking if assets are correctly mapped..."

    # Check for a specific sound file
    if [ -f "${assets.sounds.notification.arpeggio}" ]; then
      echo "OK: sounds.notification.arpeggio found at ${assets.sounds.notification.arpeggio}"
    else
      echo "ERROR: sounds.notification.arpeggio NOT found"
      exit 1
    fi

    # Add more checks here as you add more assets manually if needed
    # Example: test -f "''${assets.backgrounds.my-wallpaper}"

    touch $out
  ''
