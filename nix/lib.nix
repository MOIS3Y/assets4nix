{ lib, assetsPkg }:
let
  # Supported extensions to be stripped from attribute names
  suffixes = [
    ".mp3"
    ".png"
    ".svg"
    ".jpg"
    ".jpeg"
    ".webp"
  ];

  # Remove suffixes to create clean attribute keys
  sanitizeName = name: lib.foldl' (acc: suffix: lib.removeSuffix suffix acc) name suffixes;

  # Recursively build an attribute set mapping names to store paths
  mkAssets =
    path: absPath:
    let
      content = builtins.readDir absPath;
    in
    lib.listToAttrs (
      lib.mapAttrsToList (
        name: type:
        let
          relPath = if path == "" then name else "${path}/${name}";
          newAbsPath = absPath + "/${name}";
        in
        {
          name = sanitizeName name;
          value =
            if type == "directory" then mkAssets relPath newAbsPath else "${assetsPkg}/share/${relPath}";
        }
      ) content
    );
in
mkAssets "" ../share
