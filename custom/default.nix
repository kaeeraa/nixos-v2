{...}: let
  mkOverlay = name: import ./overlays/${name}.nix;
  mkPackage = name: final: prev: {
    ${name} = prev.callPackage ./packages/${name}.nix {};
  };
in {
  nixpkgs.overlays = [
    (mkPackage "sddm-gruvbox")
  ];
}
