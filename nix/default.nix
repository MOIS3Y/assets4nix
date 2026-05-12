{ stdenvNoCC, lib }:

stdenvNoCC.mkDerivation {
  pname = "assets4nix";
  version = "0.2.0";

  src = ../share;

  dontBuild = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share
    cp -r . $out/share/
    runHook postInstall
  '';

  meta = with lib; {
    description = "Assets collection for NixOS";
    homepage = "https://github.com/MOIS3Y/assets4nix";
    license = licenses.mit;
    platforms = platforms.all;
  };
}
