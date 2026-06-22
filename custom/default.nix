{inputs, ...}: let
  mkOverlay = name: import ./overlays/${name}.nix;
  mkPackage = name: final: prev: {
    ${name} = prev.callPackage ./packages/${name}.nix {};
  };
in {
  nixpkgs.overlays = [
    inputs.millennium.overlays.default

    (mkPackage "sddm-gruvbox")
  ];
}
