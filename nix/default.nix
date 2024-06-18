{ stdenvNoCC, lib }:

stdenvNoCC.mkDerivation {
  pname = "assets4nix";
  version = "0.1.0";

  src = ../share;

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share
    cp -r $src/* $out/share/
  '';

  meta = with lib; {
    description = "Assets collection for declarative NixOS configuration";
    homepage = "https://github.com/MOIS3Y/assets4nix";
    license = licenses.mit;
    platforms = platforms.all;
  }; 
}
