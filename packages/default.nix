{...}: {
  nixpkgs.overlays = [
    (final: prev: {sddm-gruvbox = prev.callPackage ./sddm-gruvbox.nix {};})
  ];
}
