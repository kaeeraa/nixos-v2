{pkgs ? import <nixpkgs> {}}:
pkgs.stdenv.mkDerivation rec {
  pname = "sddm-gruvbox";
  version = "1.1.0";

  src = pkgs.fetchFromGitHub {
    owner = "he1senbrg";
    repo = "sddm-gruvbox";
    rev = "v${version}";
    hash = "sha256-oM5PxNO0RTeOrWZ19gILnzhE43D4FVs6+n0enrofA6E=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/sddm/themes/sddm-gruvbox
    cp -r src/* $out/share/sddm/themes/sddm-gruvbox/

    runHook postInstall
  '';

  meta = with pkgs.lib; {
    description = "Gruvbox theme for SDDM display manager";
    homepage = "https://github.com/he1senbrg/sddm-gruvbox";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
