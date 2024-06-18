{}: {
  assets4nix  = final: prev: {
    assets4nix = final.callPackage ./default.nix { };
  };
}
